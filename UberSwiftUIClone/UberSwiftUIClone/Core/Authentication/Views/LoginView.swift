//
//  LoginView.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 03.05.2024.
//

import SwiftUI

struct LoginView: View {

    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                
                VStack {
                    
                    // image and title
                    
                    VStack(spacing: -16) {
                        Image(.uberAppIcon)
                            .resizable()
                            .frame(width: 200, height: 200)
                        
                        Text("UBER")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                    }
                    // input fields
                    
                    VStack(spacing: 32) {
                        
                        CustomInputField(title: "Email Address", placeholder: "name@example.com", text: $email)
                        CustomInputField(title: "Password", placeholder: "Enter your password", isSecureField: true, text: $password)
                        
                        Button {
                            
                        } label: {
                            Text("Forgot Password")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.top)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // social sign in view
                    
                    VStack {
                        HStack(spacing: 24) {
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                            
                            Text("Sign in with social")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                            
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                        }
                        
                        HStack(spacing: 24) {
                            Button {
                                
                            } label: {
                                Image(.facebookSignInIcon)
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(.googleSignInIcon)
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    // sign in button
                    
                    Button {
                        
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
                    
                    // sign up button
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.footnote)

                            Text("Sign Up")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
