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
    @State private var displaySearchBar = false
    
    var body: some View {
        VStack {
            TopBar(isConnected: true)
            VStack(alignment: .leading) {
                HeroSection()
                HStack {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(grayLL)
                        .onTapGesture {
                            withAnimation {
                                displaySearchBar.toggle()
                            }
                        }

                    if displaySearchBar {
                        TextField("Seach Menu", text: $searchText)
                            .foregroundStyle(blackLL)
                            .frame(height: 30)
                            .background(grayLL)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                }
            }
            .background(greenLL)
   
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                ScrollView {
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
                            VStack(alignment: .leading) {
                                Divider()
                                Text("\(dish.title ?? "")")
                                    .foregroundStyle(Color.primary)
                                    .bold()
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("\(dish.descriptionDish ?? "")\n")
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                            .foregroundStyle(Color.secondary)
                                        Text("$\(dish.price ?? "")")
                                            .foregroundStyle(Color.secondary)
                                            .bold()
                                    }
                                    Spacer()
                                    if let urlString = dish.image {
                                        AsyncImage(url: URL(string: urlString)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 80, height: 80)
                                    }
                                }
                            }
                            .padding([.horizontal, .top])
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
