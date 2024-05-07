//
//  HomeViewModel.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 06.05.2024.
//

import SwiftUI
import MapKit

final class HomeViewModel: NSObject, ObservableObject {

    @Published var drivers = [User]()
    @EnvironmentObject var authManager: AuthManager
    var currentUser: User?

    // location search properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var savedLocation: SavedLocation?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    var userLocation: CLLocationCoordinate2D?
    private let service = AuthService.shared
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }

    override init() {
        super.init()
        Task { await fetchUser() }
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }

    func fetchUser() async {
        let user = await service.fetchCurrentUser()
        guard user.accountType == .passenger else { return }
        await fetchDrivers()
    }

    func fetchDrivers() async {
        let drivers = await service.fetchDrivers()

        await MainActor.run {
            self.drivers = drivers
        }
    }
}

// MARK: - Location search helpers

extension HomeViewModel {

    func selectLocation(_ localSearch: MKLocalSearchCompletion, config: LocationResultsViewConfig) {

        locationSearch(forLocalSearchCompletion: localSearch) { response, error in

            if let error  {
                print("Location search failed with error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate

            switch config {
            case .ride:
                self.selectedUberLocation = UberLocation(
                    title: localSearch.title,
                    coordinate: coordinate
                )
            case .saveLocation:
                let savedLocation = SavedLocation(
                    title: localSearch.title,
                    address: localSearch.subtitle,
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                )
                self.savedLocation = savedLocation
                break
            }
        }
    }

    func locationSearch(
        forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
        completion: @escaping MKLocalSearch.CompletionHandler
    ) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)

        search.start(completionHandler: completion)
    }

    func computeRidePrice(forType type: RideType) -> Double {
        guard let destCoordinate = selectedUberLocation?.coordinate, let userLocation else { return 0.0 }

        let userCoordinate = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)

        let tripDistanceInMeters = userCoordinate.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }

    func getDestinationRoute(
        from userLocation: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D,
        completion: @escaping(MKRoute) -> Void
    ) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error {
                print(error.localizedDescription)
                return
            }

            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }

    func configurePickupAndDropoffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}


extension HomeViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
