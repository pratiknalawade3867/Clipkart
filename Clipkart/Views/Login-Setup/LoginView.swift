//
//  LoginView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 25/10/24.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // logo
                    logo
                    // title
                    titleView
                    
                    Spacer().frame(height: 12)
                    
                    // textfields
                    InputView(
                        placeholder: "Email and Phone number!",
                        text: $viewModel.email
                    )
                    
                    InputView(
                        placeholder: "Password",
                        isSecureField: true,
                        text: $viewModel.password
                    )
                    // forgot button
                    forgotButton
                    
                    // login button
                    
                    Button(action: {
                        login()
                    }) {
                        Text("Login")
                            .fontWeight(.bold)
                            .font(.headline) // Change font size
                            .foregroundColor(.green) // Text color
                    }
                    NavigationLink(destination: MainView(), isActive: $viewModel.isLoggedIn) {
                        EmptyView()
                    }
                }
                
                Spacer()
                
                // bottom view
                bottomView
                
                //footer view
                NavigationLink(destination: CreateAccountView()) {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.black)
                        Text("Sign Up")
                            .foregroundStyle(.teal)
                    }
                    .fontWeight(.medium)
                }
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal)
        .padding(.vertical, 8)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.loginFailed) {
            Alert(title: Text("Alert"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func login() {
        guard !viewModel.email.isEmpty, !viewModel.password.isEmpty else {
            viewModel.loginFailed = true
            viewModel.alertMessage = "Please fill some detail!"
            return
        }
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", viewModel.email, viewModel.password)
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first {
                viewModel.email = user.email ?? "" // Set the email here
                viewModel.isLoggedIn = true
                print("Login successful for user: \(user.email ?? "Unknown")")
            } else {
                viewModel.loginFailed = true
                viewModel.alertMessage = "Unknown user!"
                print("Login failed for \(viewModel.email)")
            }
        } catch {
            viewModel.loginFailed = true
            print("Failed to fetch users: \(error.localizedDescription)")
        }
    }
}

private var logo: some View {
    Image("login_image")
        .resizable()
        .scaledToFit()
}

private var titleView: some View {
    Text("Let's Connect With US!")
        .font(.title2)
        .fontWeight(.semibold)
}

private var forgotButton: some View {
    HStack {
        Spacer()
        Button {
            
        } label: {
            Text("Forgot Password?")
                .foregroundStyle(.gray)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

private var line: some View {
    VStack { Divider().frame(height: 1) }
}

private var bottomView: some View {
    VStack(spacing: 16) {
        lineorView
        appleButton
        googleButton
    }
}

private var lineorView: some View {
    HStack(spacing: 16) {
        line
        Text("or")
            .fontWeight(.semibold)
        line
    }
    .foregroundStyle(.gray)
}

private var appleButton: some View {
    Button {
        
    } label: {
        Label("Sign up with Apple", systemImage: "apple.logo")
    }
    .buttonStyle(.bordered)
}

private var googleButton: some View {
    Button {
        
    } label: {
        HStack {
            Image("google")
                .resizable()
                .frame(width: 15, height: 15)
            Text("Sign up with Google")
        }
    }
}

#Preview {
    LoginView()
}
