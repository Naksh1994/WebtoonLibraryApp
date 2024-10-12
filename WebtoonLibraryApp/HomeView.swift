//
//  HomeView.swift
//  WebtoonLibraryApp
//
//  Created by Nakshatra Verma on 11/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var currentIndex = 0
    @State private var showDots = false
    @State private var searchText = ""
    
    // Timer to hide the dots after a delay
    func hideDotsAfterDelay() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            withAnimation {
                showDots = false
            }
        }
    }
    
    // Dummy data for image names and labels
    let images = [
        ImageItem(imageName: "I Love Yoo", title: "I Love Yoo"),
        ImageItem(imageName: "Operation True Love", title: "Operation True Love"),
        ImageItem(imageName: "The Remarried Empress", title: "Remarried Empress"),
        ImageItem(imageName: "Lore Olympus", title: "Lore Olympus"),
        ImageItem(imageName: "The Mafia Nanny", title: "The Mafia Nanny"),
        ImageItem(imageName: "Refund High School", title: "Refund High School")
    ]
    
    var filteredImages: [ImageItem] {
        if searchText.isEmpty {
            return images
        } else {
            return images.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TabView(selection: $currentIndex) {
                        ForEach(0..<filteredImages.count, id: \.self) { index in
                            VStack {
                                NavigationLink(destination: ImageDetailView(
                                    imageName: filteredImages[index].imageName,
                                    title: filteredImages[index].title,
                                    description: "Description for \(filteredImages[index].title)",
                                    moreDetails: "More details about \(filteredImages[index].title)"
                                )) {
                                    Image(filteredImages[index].imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.33)
                                        .clipped()
                                }
                                Text(filteredImages[index].title)
                                    .font(.headline)
                                    .padding(.top, 10)
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .onAppear {
                        hideDotsAfterDelay()
                    }
                    .onChange(of: currentIndex) { _ in
                        showDots = true
                        hideDotsAfterDelay()
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.4)
                    
                    if showDots {
                        HStack {
                            ForEach(0..<filteredImages.count, id: \.self) { index in
                                Circle()
                                    .fill(index == currentIndex ? Color.black : Color.gray)
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .transition(.opacity)
                        .padding(.top, 5)
                    }
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredImages, id: \.self.title) { imageItem in
                            VStack {
                                NavigationLink(destination: ImageDetailView(
                                    imageName: imageItem.imageName,
                                    title: imageItem.title,
                                    description: "Description for \(imageItem.title)",
                                    moreDetails: "More details about \(imageItem.title)"
                                )) {
                                    Image(imageItem.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width * 0.45, height: 150)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                                Text(imageItem.title)
                                    .font(.headline)
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct ImageItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
}

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
                .tag(1)
            
            RatingView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Rating")
                }
                .tag(2)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
