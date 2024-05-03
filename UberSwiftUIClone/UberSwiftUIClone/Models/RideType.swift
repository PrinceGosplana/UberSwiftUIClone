//
//  RideType.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 03.05.2024.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX, black, uberXL

    var id: Int { rawValue }

    var description: String {
        switch self {
        case .uberX: "UberX"
        case .black: "UberBlack"
        case .uberXL: "UberXL"
        }
    }

    var imageName: String {
        switch self {
        case .uberX: "uber-x"
        case .black: "uber-black"
        case .uberXL: "uber-x"
        }
    }
}
