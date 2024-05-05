//
//  User.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import Foundation

struct User: Codable {
    let fullName: String
    let email: String
    let uid: String
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
}

extension User {
    static let mockUser = User(fullName: "Steven King", email: "steven@gmail.com", uid: UUID().uuidString)
}
