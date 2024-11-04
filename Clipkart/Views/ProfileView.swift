//
//  ProfileView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 28/10/24.


import SwiftUI
import CoreData

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
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
                                    Text(ViewStrings.deleteAccountTxt.getText())
                                        .foregroundStyle(.black)
                                } icon: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                    }
                }
                .navigationTitle(ViewStrings.profileLbl.getText())
                .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text(ViewStrings.profileLbl.getText())
            }
            
            NavigationStack {
                SettingsView()
                    .navigationTitle(ViewStrings.settingLbl.getText())
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text(ViewStrings.settingLbl.getText())
            }
        }
        .background(
            NavigationLink(destination: LoginView(), isActive: $viewModel.isAccountDeleted) {
                EmptyView()
            }
        )
    }
    
    private func deleteAccount(user: User) async {
        viewContext.delete(user)
        
        do {
            try viewContext.save()
            viewModel.isAccountDeleted = true
        } catch {
            // Handle the error (e.g., show an alert)
            print("Failed to delete user: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ProfileView()
}
