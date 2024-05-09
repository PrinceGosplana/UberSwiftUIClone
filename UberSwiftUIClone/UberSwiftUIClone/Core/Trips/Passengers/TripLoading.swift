//
//  TripLoading.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 08.05.2024.
//

import SwiftUI

struct TripLoading: View {
    var body: some View {
        VStack {
            CapsuleView()

            HStack {
                Text("Connecting you to a driver")
                    .font(.headline)
                    .padding()

                Spacer()

                Spinner(lineWidth: 6, height: 64, width: 64)
                    .padding()
            }
            .padding(.bottom, 24)
        }
        .background(Color.theme.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    TripLoading()
}
