//
//  ForgotPasswordView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 03/11/24.
//

import SwiftUI

import SwiftUI
import CoreData

struct ForgotPasswordView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var email: String = ""
    @State private var newPassword: String = "" // New password input
    @State private var isError: Bool = false // Track error state
    @State private var successMessage: String? // Track success message
    @Environment(\.dismiss) var dismiss  // For dismissing the view
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Reset Password")
                    .font(.largeTitle)
                
                Text("Enter the email associated with your account and your new password.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 32)
            
            InputView(placeholder: "Enter your email", text: $email)
                .padding(.bottom, 16)
            
            InputView(placeholder: "Enter your new password", text: $newPassword) // Secure input for password
                .padding(.bottom, 16)
            
            Button {
                Task {
                    await resetPassword(by: email, newPassword: newPassword)
                }
            } label: {
                Text("Reset Password")
            }
            .buttonStyle(.bordered)
            .disabled(email.isEmpty || newPassword.isEmpty) // Disable button if fields are empty
            
            // Show success or error message
            if let message = successMessage {
                Text(message)
                    .foregroundColor(.green)
                    .padding(.top, 8)
            }
            
            if isError {
                Text("Failed to reset password. Please check your email.")
                    .foregroundColor(.red)
                    .padding(.top, 8)
            }
            
            Spacer()
        }
        .padding()
        .toolbarRole(.editor)
        .onAppear {
            email = ""
            newPassword = ""
            isError = false
            successMessage = nil
        }
        .alert(isPresented: $isError) {
            Alert(title: Text("Alert"), message: Text(successMessage ?? ""), dismissButton: .default(Text("OK")) {
                dismiss()
            })
        }
    }
    
    // MARK: - Reset Password Function
    private func resetPassword(by email: String, newPassword: String) async {
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "email == %@", email)
            let users = try viewContext.fetch(request)
            
            // Check if user exists
            if let user = users.first {
                user.password = newPassword // Update the user's password
                try viewContext.save() // Save the context
                successMessage = "Password reset successfully!" // Set success message
            } else {
                isError = true // No user found with the provided email
            }
        } catch {
            isError = true // Set error state
            print("Error resetting password: \(error.localizedDescription)") // Log the error
        }
    }
}

#Preview {
    ForgotPasswordView()
}
