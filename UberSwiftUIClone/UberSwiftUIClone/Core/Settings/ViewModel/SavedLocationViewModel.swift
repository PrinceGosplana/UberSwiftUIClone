//
//  SavedLocationViewModel.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import Foundation

enum SavedLocationViewModel: Int, CaseIterable, Identifiable {
    case home, work

    var title: String {
        switch self {
        case .home: "Home"
        case .work: "Work"
        }
    }

    var imageName: String {
        switch self {
        case .home: "house.circle.fill"
        case .work: "archivebox.circle.fill"
        }
    }

    var subTitle: String {
        switch self {
        case .home: "Add Home"
        case .work: "Add Work"
        }
    }

    var id: Int { rawValue }
}
