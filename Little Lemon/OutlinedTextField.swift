//
//  OutlinedTextField.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 25/11/2023.
//

import SwiftUI

struct OutlinedTextField: View {
    let label: String
    let input: Binding<String>
    var readOnly: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundStyle(.secondary)
            Group {
                if readOnly {
                    Text(input.wrappedValue)
                } else {
                    TextField("", text: input)
                }
            }
                .textFieldStyle(.roundedBorder)
        }
        .padding([.horizontal, .top])
    }
}
