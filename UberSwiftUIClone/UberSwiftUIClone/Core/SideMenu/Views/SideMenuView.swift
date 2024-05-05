//
//  SideMenuView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import SwiftUI

struct SideMenuView: View {

    private let user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        VStack(spacing: 40) {
            // header view
            VStack(alignment: .leading, spacing: 32) {
                HStack {
                    Image(.maleProfilePhoto)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(user.fullName)
                            .font(.system(size: 16, weight: .semibold))

                        Text(user.email)
                            .font(.system(size: 14))
                            .tint(Color.theme.primaryTextColor)
                            .opacity(0.77)
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Do more with your account")
                        .font(.footnote)
                        .fontWeight(.semibold)

                    HStack {
                        Image(systemName: "dollarsign.square")
                            .font(.title2)
                            .imageScale(.medium)

                        Text("Make Money Driving")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(6)
                    }
                }

                Rectangle()
                    .containerRelativeFrame(.horizontal) { length, height in
                        length - 100
                    }
                    .frame(height: 0.75)
                    .opacity(0.7)
                    .foregroundStyle(Color(.separator))
                    .shadow(color: .black.opacity(0.7), radius: 4)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)

            // option list
            VStack {
                ForEach(SideMenuOptionViewModel.allCases) { viewModel in
                    NavigationLink(value: viewModel) {
                        SideMenuOptionView(viewModel: viewModel)
                            .padding()
                    }
                }
            }
            .navigationDestination(for: SideMenuOptionViewModel.self) { viewModel in
                switch viewModel {
                case .trips:
                    Text("Trips")
                case .wallet:
                    Text("Wallet")
                case .settings:
                    SettingsView(user: user)
                case .messages:
                    Text("Messages")
                }
            }

            Spacer()
        }
        .padding(.top, 32)
    }
}

#Preview {
    NavigationStack {
        SideMenuView(user: User.mockUser)
    }
}
