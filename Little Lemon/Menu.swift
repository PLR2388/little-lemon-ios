//
//  Menu.swift
//  Little Lemon
//
//  Created by Paul-Louis Renard on 17/11/2023.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("Description")
            TextField("Seach Menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink {
                            VStack {
                                Text("Title")
                                Text(dish.title ?? "")
                                Text("Description")
                                Text(dish.descriptionDish ?? "")
                                if let urlString = dish.image {
                                    Text("Image")
                                    AsyncImage(url: URL(string: urlString)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                }
                                Text("Price")
                                Text("$\(dish.price ?? "")")
                                Text("Category")
                                Text(dish.category ?? "")
                            }
                        } label: {
                            HStack {
                                Text("\(dish.title ?? "") $\(dish.price ?? "")")
                                if let urlString = dish.image {
                                    AsyncImage(url: URL(string: urlString)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    private func getMenuData() {
        PersistenceController.shared.clear()
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data,_, error in
            if let data {
                let jsonDecoder = JSONDecoder()
                do {
                    let menuList = try jsonDecoder.decode(MenuList.self, from: data)
                    let menuItems = menuList.menu
                    for menuItem in menuItems {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.id = Int64(menuItem.id)
                        dish.category = menuItem.category
                        dish.descriptionDish = menuItem.description
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        try? viewContext.save()
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
 
            }
        }
        task.resume()
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    private func buildPredicate() -> NSPredicate {
        return searchText.isEmpty ? NSPredicate(value: true):
        NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

#Preview {
    Menu()
}
