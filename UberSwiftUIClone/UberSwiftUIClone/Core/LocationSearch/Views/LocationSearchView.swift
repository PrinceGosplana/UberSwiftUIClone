//
//  LocationSearchView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import SwiftUI

struct LocationSearchView: View {

    @State private var startLocationText = ""
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack(spacing: 1) {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }

                VStack {
                    TextField("Current location...", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)

                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)

            Divider()
                .padding(.top, 18)

            LocationSearchResults(viewModel: viewModel, config: .ride)
        }
        .background(Color.theme.backgroundColor)
    }
}

#Preview {
    LocationSearchView()
        .environmentObject(LocationSearchViewModel())
}
