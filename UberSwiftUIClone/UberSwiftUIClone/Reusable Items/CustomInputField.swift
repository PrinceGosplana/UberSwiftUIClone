//
//  CustomInputField.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 04.05.2024.
//

import SwiftUI

struct CustomInputField: View {
    let title: String
    let placeholder: String
    var isSecureField = false
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(.white)
                .font(.footnote)
                .fontWeight(.semibold)

            if isSecureField {
                SecureField(placeholder, text: $text)
                    .foregroundStyle(.white)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundStyle(.white)
            }

            Rectangle()
                .foregroundStyle(Color(.init(white: 1, alpha: 0.3)))
                .frame(maxWidth: .infinity - 32, maxHeight: 0.7)
        }
    }
}

#Preview {
    CustomInputField(title: "Title", placeholder: "placeholder", text: .constant("text"))
}
