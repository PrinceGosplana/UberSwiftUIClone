//
//  MockTripService.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 08.05.2024.
//


actor MockTripService: TripServiceProtocol {
    static let shared = MockTripService()
    func fetchTrips() async throws -> [Trip] {
        Trip.mockTrips
    }
}
