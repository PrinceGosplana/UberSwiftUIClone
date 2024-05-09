//
//  PickupPassenger.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 09.05.2024.
//

import SwiftUI

struct PickupPassenger: View {

    let trip: Trip
    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            CapsuleView()

            VStack {
                HStack {
                    Text("Pickup \(trip.passengerName) at \(trip.pickupLocationName)")
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 44)

                    Spacer()

                    VStack {
                        Text("\(trip.travelTimeToPassenger)")

                        Text("min")
                    }
                    .bold()
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(.systemBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                }
                .padding()

                Divider()
            }

            VStack {
                HStack {
                    Image(.maleProfilePhoto)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        Text(trip.passengerName)
                            .fontWeight(.bold)

                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(Color(.systemYellow))
                                .imageScale(.small)

                            Text("4.8")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }

                    Spacer()

                    VStack(spacing: 6) {
                        Text("Earnings")

                        Text("\(trip.tripCost.toCurrency())")
                            .font(.system(size: 24, weight: .semibold))
                    }
                }

                Divider()
            }
            .padding()

            Button {
                viewModel.cancelTripAsDriver()
            } label: {
                Text("Accept")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .background(Color(.systemBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
            }
        }
        .modifier(InfoViewModifiers())
    }
}

#Preview {
    PickupPassenger(trip: Trip.mockTrips[0])
        .environmentObject(HomeViewModel())
}

