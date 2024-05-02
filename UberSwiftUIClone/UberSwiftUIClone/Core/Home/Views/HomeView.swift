//
//  HomeView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import SwiftUI

struct HomeView: View {

    @State private var showLocationSearchView = false

    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()

            if showLocationSearchView {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
            } else {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            showLocationSearchView.toggle()
                        }
                    }
            }

            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

#Preview {
    HomeView()
}
