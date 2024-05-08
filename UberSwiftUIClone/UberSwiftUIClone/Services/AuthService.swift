//
//  AuthService.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import Foundation

actor AuthService: AuthServiceProtocol {

    private var user: User?

    static let shared = AuthService()
    
    func registerUser(withEmail email: String, password: String, fullName: String) async throws -> String {
        UUID().uuidString
    }

    func login(withEmail email: String, password: String) async throws -> String {
        UUID().uuidString
    }

    func signOut() async { }

    func fetchCurrentUser() async -> User {
        user = User.mockDriver
        return user ?? User.mockUser
    }

    func fetchDrivers() async -> [User] {
        guard let user else { return [] }
        guard user.accountType == .passenger else { return [] }
        return User.mockDrivers
    }
}
