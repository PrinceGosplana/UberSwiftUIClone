//
//  AuthService.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import Foundation

actor AuthService: AuthServiceProtocol {
    func registerUser(withEmail email: String, password: String, fullName: String) async throws -> String {
        UUID().uuidString
    }

    func login(withEmail email: String, password: String) async throws -> String {
        UUID().uuidString
    }

    func signOut() async { }

    func fetchUser() async throws -> User {
        User.mockUser
    }
}
