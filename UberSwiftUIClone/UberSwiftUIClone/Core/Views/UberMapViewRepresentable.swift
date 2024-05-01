//
//  UberMapViewRepresentable.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {

    let mapView = MKMapView()

    func makeUIView(context: Context) -> some UIView {
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable

        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
    }
}
