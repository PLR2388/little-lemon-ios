//
//  PrimaryButtonView.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 25/11/2023.
//

import SwiftUI

struct PrimaryButtonView: View {
    let action: () -> Void
    let text: String
    
    public init(_ text: String, action: @escaping () -> Void) {
        self.action = action
        self.text = text
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundStyle(blackLL)
                .frame(width: 150, height: 50)
                .background(.yellowLL)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
    }
}
