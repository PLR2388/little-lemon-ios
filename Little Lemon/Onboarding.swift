//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 17/11/2023.
//

import SwiftUI

let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                TopBar(isConnected: false)
                HeroSection()
                NavigationLink(isActive: $isLoggedIn) {
                    Home()
                } label: {
                    EmptyView()
                }
                OutlinedTextField(label: "First Name *", input: $firstName)
                OutlinedTextField(label: "Last Name *", input: $lastName)
                OutlinedTextField(label: "Email *", input: $email)
                    .padding(.bottom)
                
                PrimaryButtonView("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    }
                }
                Spacer()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
