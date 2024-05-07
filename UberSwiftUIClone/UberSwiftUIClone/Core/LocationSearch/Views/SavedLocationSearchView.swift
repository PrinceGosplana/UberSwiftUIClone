//
//  SavedLocationSearchView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import SwiftUI

struct SavedLocationSearchView: View {

    @EnvironmentObject var authManager: AuthManager
    @StateObject var viewModel = HomeViewModel()
    let config: SavedLocationViewModel

    var body: some View {
        VStack {
            TextField("Search for a location...", text: $viewModel.queryFragment)
                .frame(height: 32)
                .padding(.leading)
                .background(Color(.systemGray5))
                .padding()

            Spacer()

            LocationSearchResults(viewModel: viewModel, config: .saveLocation(config))
        }
        .onChange(of: viewModel.savedLocation) {
            switch config {
            case .home:
                authManager.currentUser?.homeLocation = viewModel.savedLocation
            case .work:
                authManager.currentUser?.workLocation = viewModel.savedLocation
            }
        }
        .navigationTitle(config.subTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SavedLocationSearchView(config: .home)
            .environmentObject(AuthManager(service: MockAuthService()))
    }
}
