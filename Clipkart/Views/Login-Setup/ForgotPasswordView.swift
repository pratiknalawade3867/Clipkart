//
//  ForgotPasswordView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 03/11/24.
//

import SwiftUI
import CoreData

struct ForgotPasswordView: View {
    @Environment(\.managedObjectContext) private var context
    @State var email: String
    @State private var newPassword: String = ""
    @State private var message: String?
    
    var body: some View {
        VStack {
            TextField("User Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("New Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Reset Password") {
                resetPassword()
            }
            .padding()
            
            if let message = message {
                Text(message)
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
    
    private func resetPassword() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                user.password = newPassword
                try context.save()
                message = "Password reset successfully!"
            } else {
                message = "User not found."
            }
        } catch {
            message = "Failed to reset password."
        }
    }
}
