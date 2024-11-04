//
//  ProfileView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 28/10/24.


import SwiftUI
import CoreData

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @State private var isAccountDeleted: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    private var users: FetchedResults<User>
    
    var body: some View {
        TabView {
            NavigationStack {
                List {
                    Section {
                        if let user = users.first {
                            HStack(spacing: 16) {
                                Text(user.email ?? ViewStrings.blank.getText())
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Color(.lightGray))
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.fullname?.uppercased() ?? "noth")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    
                                    Text(user.email?.lowercased() ?? ViewStrings.blank.getText())
                                        .font(.footnote)
                                }
                            }
                            
                            Button {
                                Task {
                                    await deleteAccount(user: user)
                                }
                            } label: {
                                Label {
                                    Text("Delete Account")
                                        .foregroundStyle(.black)
                                } icon: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Profile")
                .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            
            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
        .background(
            NavigationLink(destination: LoginView(), isActive: $isAccountDeleted) {
                EmptyView()
            }
        )
    }
    
    private func deleteAccount(user: User) async {
        viewContext.delete(user)
        
        do {
            try viewContext.save()
            isAccountDeleted = true
        } catch {
            // Handle the error (e.g., show an alert)
            print("Failed to delete user: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ProfileView()
}
