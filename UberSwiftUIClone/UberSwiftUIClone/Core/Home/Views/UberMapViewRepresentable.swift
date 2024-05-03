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
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedUberLocation?.coordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
        }
    }

    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties

        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?

        // MARK: - Lifecycle

        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        // MARK: - MKMapViewDelegate

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {

            userLocationCoordinate = userLocation.coordinate

            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
            currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }

        // MARK: - Helpers

        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }

        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate else { return }
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(
                    route.polyline.boundingMapRect,
                    edgePadding: .init(
                        top: 64,
                        left: 32,
                        bottom: 500,
                        right: 32
                    )
                )
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }

        func getDestinationRoute(
            from userLocation: CLLocationCoordinate2D,
            to destination: CLLocationCoordinate2D,
            completion: @escaping(MKRoute) -> Void
        ) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destinationPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destinationPlacemark)

            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }

                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }

        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)

            if let currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
