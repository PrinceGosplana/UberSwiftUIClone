//
//  DriverAnnotation.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 06.05.2024.
//

import MapKit

final class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let uid: String

    init(driver: User) {
        let coordinate = CLLocationCoordinate2D(
            latitude: driver.coordinates.latitude,
            longitude: driver.coordinates.longitude
        )
        self.coordinate = coordinate
        self.uid = driver.uid
    }
}
