//
//  SavedLocationSearchView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 05.05.2024.
//

import SwiftUI

struct SavedLocationSearchView: View {

    @StateObject var viewModel = LocationSearchViewModel()

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .imageScale(.medium)
                    .padding(.leading)

                TextField("Search for a location...", text: $viewModel.queryFragment)
                    .frame(height: 32)
                    .padding(.leading)
                    .background(Color(.systemGray5))
                    .padding(.trailing)
            }
            .padding(.top)

            Spacer()

            LocationSearchResults(viewModel: viewModel, config: .saveLocation)
        }
        .navigationTitle("Add Home")
    }
}

#Preview {
    NavigationStack {
        SavedLocationSearchView()
    }
}
