//
//  TripAccepted.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 08.05.2024.
//

import SwiftUI

struct TripAccepted: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)

            // pickup info view
            VStack {
                HStack {
                    Text("Meet your driver at Apple Campus")
                        .font(.body)
                        .frame(height: 44)
                        .lineLimit(2)
                        .padding(.trailing)

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

            // driver info view
            VStack {
                HStack {
                    Image(.maleProfilePhoto)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Kevin")
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

                    // driver vehicle info
                    VStack(alignment: .center) {
                        Image(.uberX)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 64)

                        HStack {
                            Text("Mersedes S -")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.gray)

                            Text("5o43958")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .frame(width: 160)
                        .padding(.bottom)
                    }
                }

                Divider()
            }
            .padding()

            Button {

            } label: {
                Text("CANCEL TRIP")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color(.systemRed))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .padding([.leading, .trailing], 16)
            }
        }
        .padding(.bottom, 32)
        .background(Color.theme.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    TripAccepted()
}
