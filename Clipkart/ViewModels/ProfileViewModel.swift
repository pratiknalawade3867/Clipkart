//
//  ProfileViewModel.swift
//  Clipkart
//
//  Created by pratik.nalawade on 31/10/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAccountDeleted: Bool = false
    
    // Other properties and methods...
}
