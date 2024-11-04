//
//  SettingsView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 28/10/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text(ViewStrings.workinprogressLbl.getText())
                    .font(.largeTitle)
                    .padding()
            }
            .navigationTitle(ViewStrings.settingLbl.getText())
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SettingsView()
}
