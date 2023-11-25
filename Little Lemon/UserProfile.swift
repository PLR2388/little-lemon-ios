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
            TopBar(isConnected: true)
            VStack(alignment: .leading) {
                Text("Personal information")
                Image("profile")
                    .resizable()
                    .frame(width: 50, height: 50)
                ZStack {
                    Text(firstName ?? "")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .border(Color.black)
                
        
                    
                Text(lastName ?? "")
                Text(email ?? "")
                Button("Logout") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    UserProfile()
}
