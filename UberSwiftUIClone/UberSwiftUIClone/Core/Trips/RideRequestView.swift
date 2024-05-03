//
//  RideRequestView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 02.05.2024.
//

import SwiftUI

struct RideRequestView: View {

    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            // trip info view

            HStack {
                
                // indicator view

                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }

                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Current location")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Spacer()

                        Text(locationViewModel.pickupTime ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom, 10)

                    HStack {
                        if let location = locationViewModel.selectedUberLocation {
                            Text(location.title)
                                .font(.subheadline)
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                        }

                        Spacer()

                        Text(locationViewModel.dropOffTime ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(.leading, 8)
                }
                .foregroundStyle(.gray)


            }
            .padding()

            Divider()

            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading, spacing: 4) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()

                            VStack(alignment: .leading, spacing: 4) {
                                Text(type.description)

                                Text(locationViewModel.computeRidePrice(forType: type).toCurrency())

                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(8)
                        }
                        .frame(width: 112, height: 140)
                        .background(Color(type == selectedRideType ? .systemBlue : .systemGroupedBackground))
                        .scaleEffect(type == selectedRideType ? 1.1 : 1.0)
                        .foregroundStyle(type == selectedRideType ? .white : .black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)

            Divider()
                .padding(.vertical, 8)

            // payment option view

            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .foregroundStyle(.white)
                    .padding(.leading)

                Text("*** 1234")
                    .fontWeight(.bold)

                Spacer()

                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)

            // request ride button

            Button {

            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .padding([.leading, .trailing], 16)
            }
        }
        .padding(.bottom, 32)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    RideRequestView()
        .environmentObject(LocationSearchViewModel())
}
