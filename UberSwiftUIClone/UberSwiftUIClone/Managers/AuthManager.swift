//
//  AuthViewModel.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import Foundation

final class AuthManager: ObservableObject {

    private let service: AuthServiceProtocol
    @MainActor @Published var currentUser: User?

    init(service: AuthServiceProtocol) {
        self.service = service
    }

    func registerUser(withEmail email: String, password: String, fullName: String) async {
        do {
            let uid = try await service.registerUser(withEmail: email, password: password, fullName: fullName)
            await MainActor.run {
                currentUser = User(
                    fullName: fullName.isEmpty ? User.mockUser.fullName : fullName,
                    email: email.isEmpty ? User.mockUser.email : email,
                    uid: uid
                )
            }
        } catch {
            print("Register error \(error.localizedDescription)")
        }
    }

    func login(withEmail email: String, password: String) async {
        do {
            let uid = try await service.login(withEmail: email, password: password)
            await MainActor.run {
                currentUser = User(
                    fullName: User.mockUser.fullName,
                    email: email.isEmpty ? User.mockUser.email : email,
                    uid: uid
                )
            }
        } catch {
            print("Login error \(error.localizedDescription)")
        }
    }

    func signOut() async {
        await service.signOut()
        await MainActor.run {
            currentUser = nil
        }
    }

    func fetchUser() async {
        if await currentUser != nil  { return }
        do {
            let user = try await service.fetchUser()
            await MainActor.run {
                currentUser = user
                print("hello \(user.fullName)")
            }
        } catch {
            print("Fetch user error - \(error.localizedDescription)")
        }
    }

}
