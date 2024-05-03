//
//  RideRequestView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 02.05.2024.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)

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

                        Text("1:30 PM")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom, 10)

                    HStack {
                        Text("Starbucks Coffe")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)

                        Spacer()

                        Text("1:45 PM")
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
                    ForEach(0 ..< 3, id: \.self) { _ in
                        VStack(alignment: .leading) {
                            Image(.uberX)
                                .resizable()
                                .scaledToFit()

                            VStack(spacing: 4) {
                                Text("UberX")

                                Text("$22.04")

                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(8)
                        }
                        .frame(width: 112, height: 140)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
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
                Text("CONFIRM")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .padding([.leading, .trailing], 16)
            }
        }
        .background(.white)
    }
}

#Preview {
    RideRequestView()
}
