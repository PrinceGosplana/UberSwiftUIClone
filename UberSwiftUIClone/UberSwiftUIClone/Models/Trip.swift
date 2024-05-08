//
//  Trip.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 07.05.2024.
//

import SwiftUI

enum TripState: Int, Codable {
    case requested, rejected, accepted
}

struct Trip: Identifiable, Codable {
    let id: String
    let passengerUid: String
    let driverUid: String
    let passengerName: String
    let driverName: String
    let passengerLocation: GeoPoint
    let driverLocation: GeoPoint
    let pickupLocationName: String
    let dropoffLocationName: String
    let pickupLocationAddress: String
    let pickupLocation: GeoPoint
    let dropoffLocation: GeoPoint
    let tripCost: Double
    var distanceToPassenger: Double
    var travelTimeToPassenger: Int
    var state: TripState
}

extension Trip {
    static let mockTrips: [Trip] = [
        .init(
            id: UUID().uuidString,
            passengerUid: "BC0B7A87-B914-47AA-A4A5-E37294CF236E",
            driverUid: "31E9E3BE-C5FD-4B6D-8556-32AE8C5F3428",
            passengerName: "Steven King",
            driverName: "Reno Logan",
            passengerLocation: GeoPoint(latitude: 37.38, longitude: -122.05),
            driverLocation: GeoPoint(latitude: 37.32, longitude: -122.03),
            pickupLocationName: "123 Main str",
            dropoffLocationName: "34 Square",
            pickupLocationAddress: "12 Base ave",
            pickupLocation: GeoPoint(latitude: 37.38, longitude: -122.05),
            dropoffLocation: GeoPoint(latitude: 37.32, longitude: -122.03),
            tripCost: 50.0,
            distanceToPassenger: 1000,
            travelTimeToPassenger: 24,
            state: .requested
        )
    ]
}
