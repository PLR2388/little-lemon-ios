//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 18/11/2023.
//

import Foundation

struct MenuItem: Decodable {
    let id: Int
    let title: String
    let description: String
    let image: String
    let price: String
    let category: String
}
