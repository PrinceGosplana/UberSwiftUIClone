//
//  HomeView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()

            LocationSearchActivationView()
                .padding(.top, 72)
                .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
