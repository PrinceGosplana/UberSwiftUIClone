//
//  UberLocation.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 03.05.2024.
//

import CoreLocation

struct UberLocation: Identifiable {
    let id = UUID().uuidString
    let title: String
    let coordinate: CLLocationCoordinate2D
}
