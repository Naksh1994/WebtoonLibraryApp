//
//  RatingView.swift
//  WebtoonLibraryApp
//
//  Created by Nakshatra Verma on 12/10/24.
//

import SwiftUI
import SwiftUICharts // If using charts

struct RatingView: View {
    @State private var ratings: [Int] = [0, 0, 0, 0, 0]  // Number of people who rated 1, 2, 3, 4, and 5 stars
    @State private var showRatingScreen = false
    
    var totalRatings: Int {
        return ratings.reduce(0, +)
    }
    
    var averageRating: Double {
        let totalStars = zip(ratings, 1...5).map { $0 * $1 }.reduce(0, +)
        return totalRatings == 0 ? 0 : Double(totalStars) / Double(totalRatings)
    }
    
    var body: some View {
        VStack {
            Text("Average Rating: \(String(format: "%.1f", averageRating))/5")
                .font(.largeTitle)
                .padding(.bottom, 80)
            
            RatingPieChartView(ratings: ratings)  // Using the corrected Pie Chart View
                .frame(height: 300)
                .padding()
            
            Spacer()
            
            Button(action: {
                showRatingScreen.toggle()
            }) {
                Text("Rate the App")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .sheet(isPresented: $showRatingScreen) {
            RateAppScreen(ratings: $ratings)
        }
    }
}

