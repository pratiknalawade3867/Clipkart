//
//  CreateAccountViewModel.swift
//  Clipkart
//
//  Created by pratik.nalawade on 25/10/24.
//

import Foundation
import CoreData
import UIKit

class CreateAccountViewModel: ObservableObject {
    var userTags: [UserTags] = []
    @Published var email: String =   ""
    @Published var fullName: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var registrationSuccess: Bool = false
    @Published var registrationFail: Bool = false
    @Published var alertMessage: String = ""
    @Published var emailError: String?
    @Published var fullNameError: String?
    
    func validateFields() -> Bool {
        let isValid = true
        
        emailError = email.isEmpty ? "Email is required" : nil
        fullNameError = fullName.isEmpty ? "Full Name is required" : nil
        
        return isValid
    }
}
