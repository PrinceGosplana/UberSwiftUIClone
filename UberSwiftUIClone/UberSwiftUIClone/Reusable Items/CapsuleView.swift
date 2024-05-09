//
//  RoundedView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 09.05.2024.
//

import SwiftUI

struct CapsuleView: View {
    var body: some View {
        Capsule()
            .foregroundStyle(Color(.systemGray5))
            .frame(width: 48, height: 6)
            .padding(.top, 8)
    }
}

#Preview {
    CapsuleView()
}
