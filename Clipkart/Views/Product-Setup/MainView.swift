//
//  MainView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 25/10/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var isMenuOpen = false
    @State private var isCart = false
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ZStack {
            List {
                ForEach(Array(viewModel.products.enumerated()), id: \.element.id) { index, product in
                    if NetworkMonitor.shared.netOn {
                        NavigationLink {
                            ProductDetailsView(products: viewModel.products, index: index)
                        } label: {
                            ProductRowView(product: product)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .alert("Please turn on your internet!", isPresented: $viewModel.isNetClosed) {}
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isMenuOpen.toggle() // Toggle the menu when tapped
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.black)
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isCart = true // Toggle the CartView when tapped
                    }) {
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
            }
            .background(
                NavigationLink(destination: CartView().environmentObject(cartManager), isActive: $isCart) {
                    EmptyView()
                }
                    .hidden() // Hide the navigation link
            )
            // Side menu
            if isMenuOpen {
                SideMenu(isMenuOpen: $isMenuOpen)
                    .transition(.move(edge: .leading))
                    .zIndex(1) // Ensure the side menu is above the tab view
                    .offset(x: -50) // Adjust this value to move the menu further left
            }
            // ProgressView while loading
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5) // Make the spinner larger
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
            }
        }
        .animation(.easeInOut, value: isMenuOpen)
        .task {
            await viewModel.fetchProducts()
        }
    }
}

struct SideMenu: View {
    @Binding var isMenuOpen: Bool
    @State private var isLogOut:Bool = false
    @State private var isExplore:Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Button(action: {
                // Handle Settings action
                isMenuOpen = false // Close menu after selection
            }) {
                HStack {
                    // Wish symbol (heart icon)
                    Image(systemName: "heart.fill") // You can also use "heart" if you want an empty heart
                        .font(.title) // Icon size
                        .foregroundColor(.white) // Icon color
                    
                    // Text
                    Text(ViewStrings.mywishlistLbl.getText())
                        .font(.headline) // Change font size
                        .foregroundColor(.white) // Text color
                        .padding(.leading, 8) // Space between icon and text
                }
                .padding() // Internal padding
                .background(Color.black) // Background color
                .cornerRadius(120) // Rounded corners
            }
            
            .padding() // Outer padding to separate from other views
            .frame(maxWidth: .infinity, alignment: .leading) // Align to the leading edge
            
            Button(action: {
                // Handle Settings action
                isExplore = true // will go to setting and profile
            }) {
                HStack {
                    // Explore symbol (magnifying glass icon)
                    Image(systemName: "magnifyingglass") // You can also use "app.glyph" or other icons based on your preference
                        .font(.title) // Icon size
                        .foregroundColor(.white) // Icon color
                    
                    // Text
                    Text(ViewStrings.exploreLbl.getText())
                        .font(.headline) // Change font size
                        .foregroundColor(.white) // Text color
                        .padding(.leading, 8) // Space between icon and text
                }
                .padding() // Internal padding
                .background(Color.black) // Background color
                .cornerRadius(120) // Rounded corners
            }
            
            .padding() // Outer padding to separate from other views
            .frame(maxWidth: .infinity, alignment: .leading) // Align to the leading edge
            
            NavigationLink(destination: ProfileView(), isActive: $isExplore) {
                EmptyView()
            }
            
            Button(action: {
                // Handle Settings action
                isMenuOpen = false // Close menu after selection
            }) {
                HStack {
                    // Sell/Market symbol (dollar sign)
                    Image(systemName: "dollarsign.circle.fill") // Icon for selling or market
                        .font(.title) // Icon size
                        .foregroundColor(.white) // Icon color
                    
                    // Text
                    Text(ViewStrings.sellonflipkartLbl.getText())
                        .font(.headline) // Change font size
                        .foregroundColor(.white) // Text color
                        .padding(.leading, 8) // Space between icon and text
                }
                .padding() // Internal padding
                .background(Color.black) // Background color
                .cornerRadius(120) // Rounded corners
            }
            
            .padding() // Outer padding to separate from other views
            .frame(maxWidth: .infinity, alignment: .leading) // Align to the leading edge
            
            Button(action: {
                // Handle Settings action
                isMenuOpen = false // Close menu after selection
            }) {
                HStack {
                    // Feedback symbol (speech bubble icon)
                    Image(systemName: "bubble.left.fill") // Icon for feedback
                        .font(.title) // Icon size
                        .foregroundColor(.white) // Icon color
                    
                    // Text
                    Text(ViewStrings.feedbackLbl.getText())
                        .font(.headline) // Change font size
                        .foregroundColor(.white) // Text color
                        .padding(.leading, 8) // Space between icon and text
                }
                .padding() // Internal padding
                .background(Color.black) // Background color
                .cornerRadius(120) // Rounded corners
            }
            
            .padding() // Outer padding to separate from other views
            .frame(maxWidth: .infinity, alignment: .leading) // Align to the leading edge
            
            Button(action: {
                // Handle Settings action
                isMenuOpen = false // Close menu after selection
            }) {
                HStack {
                    // Help symbol (question mark icon)
                    Image(systemName: "questionmark.circle.fill") // Icon for help
                        .font(.title) // Icon size
                        .foregroundColor(.white) // Icon color
                    
                    // Text
                    Text(ViewStrings.helpbotLbl.getText())
                        .font(.headline) // Change font size
                        .foregroundColor(.white) // Text color
                        .padding(.leading, 8) // Space between icon and text
                }
                .padding() // Internal padding
                .background(Color.black) // Background color
                .cornerRadius(120) // Rounded corners
            }
            
            .padding() // Outer padding to separate from other views
            .frame(maxWidth: .infinity, alignment: .leading) // Align to the leading edge
            
            Button(action: {
                // Handle Settings action
                isLogOut = true // Close user session
            }) {
                HStack {
                    // Exit symbol (icon)
                    Image(systemName: "xmark.circle.fill")
                        .font(.title) // Icon size
                        .foregroundColor(.white) // Icon color
                    
                    // Text
                    Text(ViewStrings.logoutBtn.getText())
                        .font(.headline) // Change font size
                        .foregroundColor(.white) // Text color
                        .padding(.leading, 8) // Space between icon and text
                }
                .padding() // Internal padding
                .background(Color.black) // Background color
                .cornerRadius(120) // Rounded corners
            }
            
            .padding() // Outer padding to separate from other views
            .frame(maxWidth: .infinity, alignment: .leading) // Align to the leading edge
            
            NavigationLink(destination: LoginView(), isActive: $isLogOut) {
                EmptyView()
            }
            Spacer()
        }
        .frame(width: 290)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(185) // Optional: add corner radius for a softer look
        .edgesIgnoringSafeArea(.vertical)
        .onTapGesture {
            isMenuOpen = false // Close menu on tap outside
        }
        .offset(x: isMenuOpen ? 0 : -290) // Off-screen when closed
        .animation(.bouncy) // Animate the movement
    }
}

#Preview {
    MainView()
}


//To check/test localization

//struct ContentViews: View {
//    @State private var email:String = ""
//    var body: some View {
//        VStack {
//            Text("Email and Phone number!")
//                .font(.headline)
//                .padding()
//
//            Text("Unknown user!")
//                .foregroundColor(.red)
//                .padding()
//
//            Button(action: {
//                print(NSLocalizedString("User saved!", comment: ""))
//            }) {
//                Text("User saved!")
//            }
//            .padding()
//
//            Text("Please fill some detail!")
//                .padding()
//
//            Text("Please fill user!")
//                .padding()
//            InputView(
//                placeholder: "Email and Phone number!",
//                text: $email
//            )
//        }
//        .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViews()
//    }
//}
