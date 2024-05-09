//
//  InfoViewModifiers.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 09.05.2024.
//

import SwiftUI

struct InfoViewModifiers: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, 32)
            .background(Color.theme.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}
