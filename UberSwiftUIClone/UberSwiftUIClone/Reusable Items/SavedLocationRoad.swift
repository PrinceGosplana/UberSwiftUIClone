//
//  SavedLocationRoad.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import SwiftUI

struct SavedLocationRoad: View {
    @EnvironmentObject var authManager: AuthManager
    let viewModel: SavedLocationViewModel
//    @Binding var user: User?

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: viewModel.imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(Color(.systemBlue))

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.theme.primaryTextColor)

                if let user = authManager.currentUser {
                    Text(viewModel.subtitle(forUser: user))
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    SavedLocationRoad(viewModel: .home)
        .environmentObject(AuthManager(service: MockAuthService()))
}
