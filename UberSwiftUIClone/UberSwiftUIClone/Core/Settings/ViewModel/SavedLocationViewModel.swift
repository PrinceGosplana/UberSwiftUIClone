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

    var databaseKey: String {
        switch self {
        case .home: "homeLocation"
        case .work: "workLocation"
        }
    }

    var id: Int { rawValue }

    func subtitle(forUser user: User) -> String {
        switch self {
        case .home:
            if let homeLocation = user.homeLocation {
                return homeLocation.title
            }
            return "Add Home"
        case .work:
            if let workLocation = user.workLocation {
                return workLocation.title
            }
            return "Add work"
        }
    }
}
