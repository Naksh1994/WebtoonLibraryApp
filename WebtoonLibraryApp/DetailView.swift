//
//  ImageDetailView.swift
//  WebtoonLibraryApp
//
//  Created by Nakshatra Verma on 11/10/24.
//

import SwiftUI

struct ImageDetailView: View {
    let imageName: String
    let title: String
    let description: String
    let moreDetails: String
    
    @State private var isFavorited = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                    .clipped()
                    .opacity(0.5)
                
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Spacer()
                    
                    Button(action: {
                        isFavorited.toggle()
                        updateFavorites()
                    }) {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .font(.system(size: 24))
                            .foregroundColor(isFavorited ? .red : .gray)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
                .padding()
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                Text(moreDetails)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            isFavorited = checkIfFavorited()
        }
    }
    
    // MARK: - Favorite Functions
    
    func updateFavorites() {
        var favorites = UserDefaults.standard.stringArray(forKey: "Favorites") ?? []
        if isFavorited {
            favorites.append(title)
        } else {
            favorites.removeAll { $0 == title }
        }
        UserDefaults.standard.setValue(favorites, forKey: "Favorites")
    }
    
    func checkIfFavorited() -> Bool {
        let favorites = UserDefaults.standard.stringArray(forKey: "Favorites") ?? []
        return favorites.contains(title)
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(imageName: "I Love Yoo", title: "I Love Yoo", description: "Sample description", moreDetails: "Sample more details")
    }
}
