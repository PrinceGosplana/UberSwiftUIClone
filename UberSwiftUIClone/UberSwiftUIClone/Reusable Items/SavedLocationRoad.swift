//
//  SavedLocationRoad.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import SwiftUI

struct SavedLocationRoad: View {

    let imageName: String
    let title: String
    let subTitle: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(Color(.systemBlue))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.theme.primaryTextColor)

                Text(subTitle)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    SavedLocationRoad(imageName: "house.circle.fill", title: "Title", subTitle: "SubTitle")
}
