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

    var baseFare: Double {
        switch self {
        case .uberX: 5
        case .black: 20
        case .uberXL: 10
        }
    }

    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600

        switch self {
        case .uberX: return distanceInMiles * 1.5 + baseFare
        case .black: return distanceInMiles * 2.0 + baseFare
        case .uberXL: return distanceInMiles * 1.75 + baseFare
        }
    }
}
