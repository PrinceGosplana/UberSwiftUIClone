//
//  MapViewActionButton.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import SwiftUI

struct MapViewActionButton: View {

    @Binding var mapState: MapViewState
    @Binding var showSideMenu: Bool
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState) )
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.black)
                .contentTransition(.symbolEffect(.replace))
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            break
        case .searchingForLocation:
            mapState = .showSideMenu
        case .locationSelected, .polylineAdded:
            mapState = .showSideMenu
            viewModel.selectedUberLocation = nil
        case .showSideMenu:
            showSideMenu.toggle()
        }
    }

    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput, .showSideMenu:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .polylineAdded:
            return "arrow.left"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput), showSideMenu: .constant(false))
        .environmentObject(LocationSearchViewModel())
        .environmentObject(AuthManager(service: MockAuthService()))
}
