//
//  LocationManager.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import CoreLocation

final class LocationManager: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}
