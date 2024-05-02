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

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
