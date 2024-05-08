//
//  User.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import Foundation

enum AccountType: Int, Codable {
    case passenger, driver
}
struct User: Codable, Hashable {

    let fullName: String
    var email: String
    let uid: String
    var accountType: AccountType
    var coordinates: GeoPoint
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.uid == rhs.uid
    }
}

extension User {
    static let mockUser = User(fullName: "Steven King", email: "steven@gmail.com", uid: "BC0B7A87-B914-47AA-A4A5-E37294CF236E", accountType: .passenger, coordinates: GeoPoint(latitude: 37.38, longitude: -122.05))

    static let mockDriver = User(fullName: "Reno Logan", email: "logan@gmail.com", uid: "31E9E3BE-C5FD-4B6D-8556-32AE8C5F3428", accountType: .driver, coordinates: GeoPoint(latitude: 37.32, longitude: -122.03))

    static let mockDrivers: [User] = [
        mockUser,
        .init(fullName: "Honda Civic", email: "civic@gmail.com", uid: "F8624FBC-076C-4619-9603-8812F03AF637", accountType: .driver, coordinates: GeoPoint(latitude: 37.39, longitude: -122.09)),
        .init(fullName: "Honda Accord", email: "accord@gmail.com", uid: "832C4061-A929-4BC2-A5A7-B2603D72D6B4", accountType: .driver, coordinates: GeoPoint(latitude: 37.37, longitude: -122.07)),
        .init(fullName: "Toyota Camry", email: "camry@gmail.com", uid: "2DC3A410-C31E-486A-B802-06A53967AAB5", accountType: .driver, coordinates: GeoPoint(latitude: 37.27, longitude: -122.03))
    ]
    
}
