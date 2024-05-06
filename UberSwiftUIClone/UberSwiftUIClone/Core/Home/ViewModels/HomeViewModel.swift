//
//  HomeViewModel.swift
//  UberSwiftUIClone
//
//  Created by Oleksandr Isaiev on 06.05.2024.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {

    @Published var drivers = [User]()
    @EnvironmentObject var authManager: AuthManager
    var currentUser: User?

}
