//
//  TripCancelled.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 09.05.2024.
//

import SwiftUI

struct TripCancelled: View {

    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        VStack {
            CapsuleView()

            Text(viewModel.tripCancelledMessage)
                .font(.headline)
                .padding(.vertical)

            Button {
                cancelTrip()
            } label: {
                Text("OK")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color(.systemBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .padding([.leading, .trailing], 16)
            }
        }
        .modifier(InfoViewModifiers())
        .frame(maxWidth: .infinity)
    }

    private func cancelTrip() {
        guard let user = viewModel.currentUser else { return }
        guard let trip = viewModel.trip else { return }

        if user.accountType == .passenger {
            if trip.state == .driverCancelled {
                viewModel.deleteTrip()
            } else if trip.state == .passengerCancelled {
                viewModel.deleteTrip()
            }
        } else {
            if trip.state == .passengerCancelled {
                viewModel.deleteTrip()
            } else if trip.state == .driverCancelled {
                viewModel.deleteTrip()
            }
        }
    }
}

#Preview {
    TripCancelled()
        .environmentObject(HomeViewModel())
}
