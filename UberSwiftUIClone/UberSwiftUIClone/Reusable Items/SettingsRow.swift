//
//  SettingsRow.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import SwiftUI

struct SettingsRow: View {

    let imageName: String
    let title: String
    let tintColor: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(tintColor)

            Text(title)
                .font(.system(size: 15))
                .foregroundStyle(Color.theme.primaryTextColor)
        }
        .padding(4)
    }
}

#Preview {
    SettingsRow(imageName: "bell.circle.fill", title: "Notification", tintColor: Color(.systemPurple))
}
