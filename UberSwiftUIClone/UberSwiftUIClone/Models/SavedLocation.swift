//
//  SavedLocation.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import Foundation

struct SavedLocation: Codable, Hashable {
    let title: String
    let address: String
    let latitude: CGFloat
    let longitude: CGFloat
}
