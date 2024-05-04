//
//  AuthViewModel.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import Foundation

final class AuthManager: ObservableObject {

    private let service: AuthServiceProtocol
    @Published var userSession: String?

    init(service: AuthServiceProtocol) {
        self.service = service
    }

    func registerUser(withEmail email: String, password: String) async {
        do {
            userSession = try await service.registerUser(withEmail: email, password: password)
        } catch {
            print("Register error \(error.localizedDescription)")
        }
    }

    func login(withEmail email: String, password: String) async {
        do {
            userSession = try await service.login(withEmail: email, password: password)
        } catch {
            print("Login error \(error.localizedDescription)")
        }
    }

    func signOut() async { 
        await service.signOut()
        userSession = nil
    }
}
