//
//  TripServiceProtocol.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 08.05.2024.
//

import Foundation

protocol TripServiceProtocol {
    func fetchTrips() async throws -> [Trip]
}
