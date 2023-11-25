//
//  TopBar.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 25/11/2023.
//

import SwiftUI

struct TopBar: View {
    let isConnected: Bool
    
    var body: some View {
        HStack {
            Image("logo")
                .frame(maxWidth: .infinity, alignment: isConnected ? .trailing : .center)
            if isConnected {
                NavigationLink(destination: UserProfile()) {
                    Image("profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 50)
                }
                .padding()
            }
        }
    }
}

#Preview {
    TopBar(isConnected: true)
}
