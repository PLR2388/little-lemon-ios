//
//  MenuTypeButton.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 26/11/2023.
//

import SwiftUI

struct MenuTypeButton: View {
    let label: String
    let isSeleted: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
           Text(label)
        }
        .foregroundColor(greenLL)
        .padding(5)
        .background(isSeleted ? Color.grayLL : Color.white)
        .cornerRadius(8)
    }
}
