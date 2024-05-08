//
//  TripService.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 08.05.2024.
//


actor TripService: TripServiceProtocol {
    static let shared = TripService()
    func fetchTrips() async throws -> [Trip] {
        Trip.mockTrips
    }
}
