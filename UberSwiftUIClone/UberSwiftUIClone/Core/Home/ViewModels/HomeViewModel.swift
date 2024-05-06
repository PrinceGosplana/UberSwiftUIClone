//
//  HomeViewModel.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 06.05.2024.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {

    @Published var drivers = [User]()
    private var authManager: AuthManager
    var currentUser: User?

    init(authManager: AuthManager) {
        self.authManager = authManager
        fetchUser()
    }

    func fetchDrivers()  {
        drivers = User.mockDrivers
    }

    func fetchUser() {
        Task {
            guard let user = await authManager.currentUser else { return }
            guard user.accountType == .passenger else { return }
            await MainActor.run {
                fetchDrivers()
            }
        }

    }
}
