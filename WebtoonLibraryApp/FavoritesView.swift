//
//  FavoritesView.swift
//  WebtoonLibraryApp
//
//  Created by Nakshatra Verma on 12/10/24.
//

import SwiftUI

struct FavoritesView: View {
    @State private var favoriteItems: [String] = []
    
    var body: some View {
        VStack {
            if favoriteItems.isEmpty {
                Text("No Favorites Yet")
                    .font(.headline)
                    .padding()
            } else {
                List(favoriteItems, id: \.self) { item in
                    Text(item)
                }
            }
        }
        .onAppear {
            loadFavorites()
        }
    }
    
    func loadFavorites() {
        favoriteItems = UserDefaults.standard.stringArray(forKey: "Favorites") ?? []
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
