//
//  AcceptTripView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 07.05.2024.
//

import SwiftUI
import MapKit

struct AcceptTripView: View {

    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090),
            span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.0245)
        ))


    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)

            // would you like to pickup view
            VStack {
                HStack {
                    Text("Would you like to pickup this passenger")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 44)

                    Spacer()

                    VStack {
                        Text("10")

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

            // user info view

            VStack {
                HStack {
                    Image(.maleProfilePhoto)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        Text("STEPHAN")
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

                        Text("$22.04")
                            .font(.system(size: 24, weight: .semibold))
                    }
                }

                Divider()
            }
            .padding()

            // pickup location info view

            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Apple Campus")
                            .font(.headline)

                        Text("Infinite Loop 1, Santa Clara Country")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }

                    Spacer()

                    VStack {
                        Text("5.2")
                            .font(.headline)
                            .fontWeight(.semibold)

                        Text("mi")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal)
                
                Map(position: $cameraPosition)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.6), radius: 10)
                    .padding()

                Divider()
            }
            // action buttons

            HStack(spacing: 32) {
                Button {

                } label: {
                    Text("Reject")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 56)
                        .background(Color(.systemRed))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                }

                Button {

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
            .padding([.top, .horizontal])
        }
    }
}

#Preview {
    AcceptTripView()
}
