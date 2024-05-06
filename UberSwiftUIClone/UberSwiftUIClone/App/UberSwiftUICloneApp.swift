//
//  UberSwiftUICloneApp.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 27.04.2024.
//

import SwiftUI

@main
struct UberSwiftUICloneApp: App {

    @StateObject var locationViewModel = LocationSearchViewModel()
    @StateObject var authManager = AuthManager(service: AuthService())
    @StateObject var homeViewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
                .environmentObject(authManager)
                .environmentObject(homeViewModel)
        }
    }
}
