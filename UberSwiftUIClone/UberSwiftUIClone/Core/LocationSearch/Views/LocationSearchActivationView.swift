//
//  LocationSearchActivetionView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 01.05.2024.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack {

                Rectangle()
                    .fill(Color.black)
                    .frame(width: 8, height: 8)
                    .padding(.horizontal)

                Text("Where to?")
                    .foregroundStyle(Color(.darkGray))

                Spacer()
            }
            .frame(idealWidth: .infinity, maxWidth: proxy.size.width - 64, maxHeight: 50, alignment: .center)
            .background(
                Rectangle()
                    .fill(Color.white)
                    .shadow(color: .black, radius: 6)
            )
        }
    }
}

#Preview {
    LocationSearchActivationView()
}
