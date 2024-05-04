//
//  RegistrationView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 03.05.2024.
//

import SwiftUI

struct RegistrationView: View {

    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }

                Text("Create new account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)

                Spacer()

                VStack {

                    VStack(spacing: 56) {
                        CustomInputField(title: "Full Name", placeholder: "Full name", text: $fullName)
                        CustomInputField(title: "Email address", placeholder: "@name@example.com", text: $email)
                        CustomInputField(title: "Create password", placeholder: "Enter your password",isSecureField: true, text: $password)
                    }
                    .padding(.leading)

                    Spacer()

                    Button {
                        Task { await authManager.registerUser(withEmail: email, password: password, fullName: fullName) }
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .foregroundStyle(.black)

                            Image(systemName: "arrow.right")
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity - 32, maxHeight: 50, alignment: .center)
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Spacer()
                }
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AuthManager(service: MockAuthService()))
}
