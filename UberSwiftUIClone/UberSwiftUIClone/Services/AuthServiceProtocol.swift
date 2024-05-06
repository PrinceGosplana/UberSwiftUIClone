//
//  AuthServiceProtocol.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

protocol AuthServiceProtocol {
    func registerUser(withEmail email: String, password: String, fullName: String) async throws -> String
    func login(withEmail email: String, password: String) async throws -> String
    func signOut() async
}
