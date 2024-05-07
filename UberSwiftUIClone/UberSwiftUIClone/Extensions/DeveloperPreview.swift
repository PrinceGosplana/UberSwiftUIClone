//
//  DeveloperPreview.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 06.05.2024.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.shared
    }
}

final class DeveloperPreview {
    static let shared = DeveloperPreview()

    let mockUser = User(
        fullName: "Dohn",
        email: "Dou",
        uid: "1111",
        accountType: .passenger,
        coordinates: GeoPoint(latitude: 38.83, longitude: -122.05),
        homeLocation: nil,
        workLocation: nil
    )
}
