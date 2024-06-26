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
    @Published var trip: Trip?
    var routeToPickupLocation: MKRoute?

    // location search properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var savedLocation: SavedLocation?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    var userLocation: CLLocationCoordinate2D?
    private let service = AuthService.shared
    private let tripService = TripService.shared
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }

    var tripCancelledMessage: String {
        guard let currentUser, let trip else { return "" }

        if currentUser.accountType == .passenger {
            if trip.state == .driverCancelled {
                return "Your driver cancelled this trip"
            } else if trip.state == .passengerCancelled {
                return "Your trip has been cancelled"
            }
        } else {
            if trip.state == .driverCancelled {
                return "Your trip has been cancelled"
            } else if trip.state == .passengerCancelled {
                return "The trip has been cancelled by the passenger"
            }
        }
        return ""
    }

    override init() {
        super.init()
        Task { await fetchUser() }
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }

    // MARK: - Helpers

    func viewForState(_ state: MapViewState, user: User) -> some View {
        switch state {
        case .noInput, .searchingForLocation, .tripRequested, .showSideMenu:
            return AnyView(Text(""))
        case .polylineAdded, .locationSelected:
            return AnyView(RideRequestView())
        case .tripRejected:
            if user.accountType == .passenger {
                return AnyView(TripLoading())
            } else {
                if let trip {
                    return AnyView(AcceptTripView(trip: trip))
                }
            }
            return AnyView(Text(""))
        case .tripAccepted:
            if user.accountType == .passenger {
                return AnyView(TripAccepted())
            } else {
                if let trip {
                    return AnyView(PickupPassenger(trip: trip))
                }
            }
            return AnyView(Text(""))
        case .tripCancelledByPassenger, .tripCancelledByDriver:
            return AnyView(TripCancelled())
        }
    }

    func fetchUser() async {
        let user = await service.fetchCurrentUser()
        currentUser = user

        if user.accountType == .passenger {
            await fetchDrivers()
        } else {
            await fetchTrips()
        }
    }

    private func updateTripState(with state: TripState) {
        guard var trip else { return }
        trip.state = state
    }

    func deleteTrip() {
        trip = nil
    }
}

// MARK: - Passenger API

extension HomeViewModel {

    func fetchDrivers() async {
        let drivers = await service.fetchDrivers()

        await MainActor.run {
            self.drivers = drivers
        }
    }

    func requestTrip() {
        guard let driver = drivers.first else { return }
        guard let currentUser else { return }
        guard let dropoffLocation = selectedUberLocation else { return }
        let dropoffCeoPoint = GeoPoint(
            latitude: dropoffLocation.coordinate.latitude,
            longitude: dropoffLocation.coordinate.longitude
        )
        let userLocation = CLLocation(latitude: currentUser.coordinates.latitude, longitude: currentUser.coordinates.longitude)
        getPlacemark(forLocation: userLocation) { [self]
            placemark,
            error in
            guard let placemark else { return }
            
            trip = Trip(
                id: UUID().uuidString,
                passengerUid: currentUser.uid,
                driverUid: driver.uid,
                passengerName: currentUser.fullName,
                driverName: driver.fullName,
                passengerLocation: currentUser.coordinates,
                driverLocation: driver.coordinates,
                pickupLocationName: placemark.name ?? "Current location",
                dropoffLocationName: dropoffLocation.title,
                pickupLocationAddress: self.addressFromPlacemark(placemark),
                pickupLocation: currentUser.coordinates,
                dropoffLocation: dropoffCeoPoint,
                tripCost: computeRidePrice(forType: .uberX),
                distanceToPassenger: 0,
                travelTimeToPassenger: 0,
                state: .requested
            )
        }
    }

    func cancelTripAsPassenger() {
        updateTripState(with: .passengerCancelled)
    }
}

// MARK: - Driver API

extension HomeViewModel {

    func addTripObserverForPassenger() {
        guard let currentUser, currentUser.accountType == .passenger else { return }
        
    }

    private func fetchTrips() async {
        do {
            let trips = try await tripService.fetchTrips()
            await MainActor.run {
                guard let trip = trips.first else { return }
                self.trip = trip
                getDestinationRoute(from: trip.driverLocation.toCoordinate(), to: trip.pickupLocation.toCoordinate()) { route in
                    self.trip?.travelTimeToPassenger = Int(route.expectedTravelTime / 60)
                    self.trip?.distanceToPassenger = route.distance
                }
            }
        } catch {
            print("Error while fetching trips \(error.localizedDescription)")
        }
    }

    func rejectTrip() {
        updateTripState(with: .rejected)
    }

    func acceptTrip() {
        updateTripState(with: .accepted)
    }

    func cancelTripAsDriver() {
        updateTripState(with: .driverCancelled)
    }
}

// MARK: - Location search helpers

extension HomeViewModel {

    func addTripObserverForDriver() {
        guard let currentUser, currentUser.accountType == .driver else { return }

        guard let trip else { return }
        getDestinationRoute(from: trip.driverLocation.toCoordinate(), to: trip.pickupLocation.toCoordinate()) { route in
            self.routeToPickupLocation = route
            self.trip?.travelTimeToPassenger = Int(route.expectedTravelTime / 60)
            self.trip?.distanceToPassenger = route.distance
        }
    }

    private func addressFromPlacemark(_ placemark: CLPlacemark) -> String {
        var result = ""

        if let thoroughfare = placemark.thoroughfare {
            result += thoroughfare
        }

        if let subthoroughfare = placemark.subThoroughfare {
            result += " \(subthoroughfare)"
        }

        if let subadministrativeArea = placemark.subAdministrativeArea {
            result += ", \(subadministrativeArea)"
        }

        return result
    }

    private func getPlacemark(forLocation location: CLLocation, completion: @escaping(CLPlacemark?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error {
                completion(nil, error)
                return
            }

            guard let placemark = placemarks?.first else { return }
            completion(placemark, nil)
        }
    }
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
