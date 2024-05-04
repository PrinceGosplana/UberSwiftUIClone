//
//  AuthViewModel.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import Foundation

final class AuthManager: ObservableObject {

    private let service: AuthServiceProtocol
    @MainActor @Published var userSession: String?

    init(service: AuthServiceProtocol) {
        self.service = service
    }

    func registerUser(withEmail email: String, password: String, fullName: String) async {
        do {
            let result = try await service.registerUser(withEmail: email, password: password, fullName: fullName)
            await MainActor.run {
                userSession = result
            }
        } catch {
            print("Register error \(error.localizedDescription)")
        }
    }

    func login(withEmail email: String, password: String) async {
        do {
            let result = try await service.login(withEmail: email, password: password)
            await MainActor.run {
                userSession = result
            }
        } catch {
            print("Login error \(error.localizedDescription)")
        }
    }

    func signOut() async { 
        await service.signOut()
        await MainActor.run {
            userSession = nil
        }
    }
}
