//
//  SideMenuOptionViewModel.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import Foundation

enum SideMenuOptionViewModel: Int, CaseIterable, Identifiable {
    case trips, wallet, settings, messages

    var title: String {
        switch self {
        case .trips: "Your Trips"
        case .wallet: "Wallet"
        case .settings: "Settings"
        case .messages: "Messages"
        }
    }

    var imageName: String {
        switch self {
        case .trips: return "list.bullet.rectangle"
        case .wallet: return "creditcard"
        case .settings: return "gear"
        case .messages: return "bubble.left"
        }
    }

    var id: Int { rawValue }
}
