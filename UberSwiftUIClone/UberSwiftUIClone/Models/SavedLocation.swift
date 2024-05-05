//
//  SavedLocation.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import Foundation

struct SavedLocation: Codable {
    let titel: String
    let address: String
    let latitude: CGFloat
    let longitude: CGFloat
}
