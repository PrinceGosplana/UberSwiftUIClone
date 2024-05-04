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
    @StateObject var authViewModel = AuthManager()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
                .environmentObject(authViewModel)
        }
    }
}
