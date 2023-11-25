//
//  HeroSection.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 25/11/2023.
//

import SwiftUI

struct HeroSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.system(size: 36, design: .serif))
                .foregroundStyle(yellowLL)

            Text("Chicago")
                .font(.headline)
                .foregroundStyle(grayLL)
            HStack {
                VStack(alignment:.leading) {
                    Text("We are a family owned")
                    Text("Mediterranean Restaurant,")
                    Text("focused on traditional")
                    Text("recipes served with a")
                    Text("modern twist.")
                }
                .foregroundStyle(grayLL)
         
                Image("hero")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
        }
        .padding()
        .background(greenLL)
    }
}

#Preview {
    HeroSection()
}
