//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 18/11/2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName = UserDefaults.standard.string(forKey: kFirstName)
    @State private var lastName = UserDefaults.standard.string(forKey: kLastName)
    @State private var email = UserDefaults.standard.string(forKey: kEmail)
    
    var body: some View {
        VStack {
            TopBar(isConnected: false)
            VStack(alignment: .leading) {
                Text("Personal information")
                Image("profile")
                    .resizable()
                    .frame(width: 50, height: 50)
     
                
                detailField(label: "Fist name", value: firstName ?? "")
                detailField(label: "Last name", value: lastName ?? "")
                detailField(label: "Email", value: email ?? "")
                
                PrimaryButtonView("Logout") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func detailField(label: String, value: String) -> some View {
        Text(label)
            .font(.caption)
            .foregroundStyle(.secondary)
        ZStack {
            Text(value)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .border(Color.black)
    }
}

#Preview {
    UserProfile()
}
