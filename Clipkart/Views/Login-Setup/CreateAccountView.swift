//
//  CreateAccountView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 25/10/24.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject var viewModel = CreateAccountViewModel()
    @Environment(\.dismiss) var dismiss  // For dismissing the view
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(spacing: 16) {
            Text(ViewStrings.createAccountWelcomeMsg.getText())
                .font(.headline).fontWeight(.medium)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            InputView(
                placeholder: "Email or Phone number *",
                text: $viewModel.email
            )
            if let emailError = viewModel.emailError {
                Text(emailError)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            
            InputView(
                placeholder: "Full Name *",
                text: $viewModel.fullName
            )
            if let fullNameError = viewModel.fullNameError {
                Text(fullNameError)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            
            InputView(
                placeholder: ViewStrings.passwordTxt.getText(),
                isSecureField: true,
                text: $viewModel.password
            )
            
            ZStack(alignment: .trailing) {
                InputView(
                    placeholder: "Confirm your password",
                    isSecureField: true,
                    text: $viewModel.confirmPassword
                )
                
                Spacer()
                
                if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty {
                    Image(systemName: "\(isValidPassword ? "checkmark" : "xmark").circle.fill")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundColor(isValidPassword ? Color(.systemGreen) : Color(.systemRed))
                }
            }
            
            Spacer()
            
            Button {
                viewModel.validateFields()
                register()
            } label: {
                Text("Create Account")
            }
            .buttonStyle(.bordered)
            
        }
        .navigationTitle("Set up your account")
        .toolbarRole(.editor)
        .padding()
        .alert(isPresented: $viewModel.registrationSuccess) {
            Alert(title: Text(ViewStrings.alertTxt.getText()), message: Text(viewModel.alertMessage), dismissButton: .default(Text(ViewStrings.okTxt.getText())) {
                dismiss()
            })
        }
    }
    
    // saving user in coredata
    private func register() {
        let newUser = User(context: viewContext)
        newUser.email = viewModel.email
        newUser.password = viewModel.password
        newUser.fullname = viewModel.fullName
        
        do {
            try viewContext.save()
            if (newUser.email != "") && (newUser.password != "") && (newUser.fullname != "") {
                viewModel.alertMessage = "User saved!"
                viewModel.registrationSuccess = true
                print("User saved as \(viewModel.email) \(viewModel.password) \(viewModel.fullName)")
            } else {
                viewModel.alertMessage = "Please fill user!"
            }
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    var isValidPassword: Bool {
        viewModel.confirmPassword == viewModel.password
    }
}

#Preview {
    CreateAccountView()
}

struct InputView: View {
    let placeholder: String
    var isSecureField: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 12) {
            if isSecureField {
                SecureField(placeholder, text: $text)
            }else {
                TextField(placeholder, text: $text)
            }
            Divider()
        }
    }
}

#Preview {
    InputView(
        placeholder: "Email or Phone number",
        text: .constant("")
    )
}
