//
//  SettingsView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            List {
                Section {
                    HStack {
                        Image(.maleProfilePhoto)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("user.fullName")
                                .font(.system(size: 16, weight: .semibold))

                            Text("user.email")
                                .font(.system(size: 14))
                                .tint(Color.theme.primaryTextColor)
                                .opacity(0.77)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .font(.title2)
                            .foregroundStyle(.gray)
                    }
                    .padding(8)
                }

                Section("Favorites") {
                    SavedLocationRoad(imageName: "house.circle.fill", title: "Home", subTitle: "Add Home")

                    SavedLocationRoad(imageName: "archivebox.circle.fill", title: "Work", subTitle: "Add Work")
                }

                Section("Settings") {
                    SettingsRow(imageName: "bell.circle.fill", title: "Notifications", tintColor: Color(.systemPurple))

                    SettingsRow(imageName: "creditcard.circle.fill", title: "Payment Methods", tintColor: Color(.systemBlue))
                }

                Section("Account") {
                    SettingsRow(imageName: "dollarsign.circle.fill", title: "Make Money Driving", tintColor: Color(.systemGreen))

                    SettingsRow(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.systemRed))
                }
                
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
