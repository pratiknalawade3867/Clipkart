//
//  Login-ViewModel.swift
//  Clipkart
//
//  Created by pratik.nalawade on 31/10/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isNavigating: Bool = false
    @Published var loginFailed: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var alertMessage: String = ""
    @Published var showingResetPassword = false
}
