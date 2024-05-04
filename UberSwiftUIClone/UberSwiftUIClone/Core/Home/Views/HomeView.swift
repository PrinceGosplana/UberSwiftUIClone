//
//  HomeView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import SwiftUI

struct HomeView: View {

    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthManager

    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            } else {
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .top) {
                        UberMapViewRepresentable(mapState: $mapState)
                            .ignoresSafeArea()

                        if mapState == .searchingForLocation {
                            LocationSearchView(mapState: $mapState)
                        } else if mapState == .noInput {
                            LocationSearchActivationView()
                                .padding(.top, 72)
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        mapState = .searchingForLocation
                                    }
                                }
                        }

                        MapViewActionButton(mapState: $mapState)
                            .padding(.leading)
                            .padding(.top, 4)
                    }

                    if mapState == .locationSelected || mapState == .polylineAdded {
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    }
                }
                .ignoresSafeArea(edges: [.bottom])
                .onReceive(LocationManager.shared.$userLocation, perform: { location in
                    if let location {
                        locationViewModel.userLocation = location
                    }
                })
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LocationSearchViewModel())
        .environmentObject(AuthManager())
}
