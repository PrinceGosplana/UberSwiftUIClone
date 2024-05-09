//
//  HomeView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import SwiftUI

struct HomeView: View {

    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false
    @EnvironmentObject var authViewModel: AuthManager
    @EnvironmentObject var homeViewModel: HomeViewModel

    var body: some View {
        Group {
            if authViewModel.currentUser == nil {
                LoginView()
            } else if let user = authViewModel.currentUser {
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(
                                color: showSideMenu ? .black : .clear,
                                radius: 10
                            )
                    }
                    .onAppear {
                        showSideMenu = false
                    }
                    .task {
                        await homeViewModel.fetchDrivers()
                    }
                }
            }
        }
    }
}

extension HomeView {
    var mapView: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()

                if mapState == .searchingForLocation {
                    LocationSearchView()
                } else if mapState == .noInput || mapState == .showSideMenu{
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                mapState = .searchingForLocation
                            }
                        }
                }

                MapViewActionButton(
                    mapState: $mapState,
                    showSideMenu: $showSideMenu
                )
                .padding(.leading)
                .padding(.top, 4)
            }

            if let user = homeViewModel.currentUser {
                if user.accountType == .passenger {
                    if mapState == .locationSelected || mapState == .polylineAdded {
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    } else if mapState == .tripRequested {
                        TripLoading()
                            .transition(.move(edge: .bottom))
                    } else if mapState == .tripAccepted {
                        TripAccepted()
                            .transition(.move(edge: .bottom))
                    } else if mapState == .tripRejected {

                    }

                } else {
                    if let trip = homeViewModel.trip {
                        if mapState == .tripRequested {
                            AcceptTripView(trip: trip, with: homeViewModel)
                                .transition(.move(edge: .bottom))
                        } else if mapState == .tripAccepted {
                            PickupPassenger(trip: trip)
                                .transition(.move(edge: .bottom))
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(edges: [.bottom])
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location {
                homeViewModel.userLocation = location
            }
        }
        .onReceive(homeViewModel.$selectedUberLocation) { location in
            if location != nil {
                mapState = .locationSelected
            }
        }
        .onReceive(homeViewModel.$trip, perform: { trip in
            guard let trip else { return }
            withAnimation(.spring()) {
                switch trip.state {
                case .requested: mapState = .tripRequested
                case .rejected: mapState = .tripRejected
                case .accepted: mapState = .tripAccepted
                }
            }
        })
//        .onReceive(homeViewModel.$drivers) { drivers in
//            if !drivers.isEmpty {  }
//        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthManager(service: MockAuthService()))
        .environmentObject(HomeViewModel())
}
