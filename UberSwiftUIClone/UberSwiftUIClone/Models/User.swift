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
    static let mockUser = User(fullName: "Steven King", email: "steven@gmail.com", uid: UUID().uuidString, accountType: .passenger, coordinates: GeoPoint(latitude: 37.38, longitude: -122.05))
    static let mockDrivers: [User] = [
        .init(fullName: "Reno Logan", email: "logan@gmail.com", uid: UUID().uuidString, accountType: .driver, coordinates: GeoPoint(latitude: 37.32, longitude: -122.03)),
        .init(fullName: "Honda Civic", email: "civic@gmail.com", uid: UUID().uuidString, accountType: .driver, coordinates: GeoPoint(latitude: 37.39, longitude: -122.09)),
        .init(fullName: "Honda Accord", email: "accord@gmail.com", uid: UUID().uuidString, accountType: .driver, coordinates: GeoPoint(latitude: 37.37, longitude: -122.07)),
        .init(fullName: "Toyota Camry", email: "camry@gmail.com", uid: UUID().uuidString, accountType: .driver, coordinates: GeoPoint(latitude: 37.27, longitude: -122.03))
    ]
    
}
