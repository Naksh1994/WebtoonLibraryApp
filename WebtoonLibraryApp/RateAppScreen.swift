//
//  RateAppScreen.swift
//  WebtoonLibraryApp
//
//  Created by Nakshatra Verma on 12/10/24.
//

import SwiftUI
import SwiftUICharts

struct RateAppScreen: View {
    @Binding var ratings: [Int] // Bind to the ratings array from RatingView
    @State private var selectedRating: Int = 0 // Track the selected star rating
    @Environment(\.presentationMode) var presentationMode // To dismiss the sheet
    
    var body: some View {
        VStack {
            Text("Rate the App")
                .font(.largeTitle)
                .padding(.top, 20)
            
            // Display 5 stars for the user to select
            HStack {
                ForEach(1..<6) { star in
                    Image(systemName: star <= selectedRating ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(star <= selectedRating ? .yellow : .gray)
                        .onTapGesture {
                            selectedRating = star // Update the selected rating
                        }
                }
            }
            .padding(.vertical)
            
            // Submit button to save the selected rating
            Button(action: {
                if selectedRating > 0 {
                    ratings[selectedRating - 1] += 1 // Increment the count for the selected rating
                    selectedRating = 0 // Reset selected rating after submission
                    presentationMode.wrappedValue.dismiss() // Dismiss the sheet
                }
            }) {
                Text("Submit Rating")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
    }
}


struct RatingPieChartView: View {
    var ratings: [Int] // The array of ratings (for 1 star, 2 stars, etc.)

    var body: some View {
        let totalRatings = ratings.reduce(0, +)
        let percentages = ratings.map { Double($0) / Double(totalRatings == 0 ? 1 : totalRatings) * 100 }
        let labels = ["1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"]
        
        VStack {
            // Display Pie Chart
            PieChartView(
                data: percentages,
                title: "Rating Distribution",
                legend: "Stars",
                style: Styles.pieChartStyleOne, // Custom chart style
                dropShadow: false
            )
            .frame(height: 300)
            .padding()

            // Display rating details below the chart
            if totalRatings == 0 {
                Text("No ratings yet")
                    .font(.title3)
                    .foregroundColor(.gray)
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(0..<ratings.count, id: \.self) { index in
                        HStack {
                            Text("\(labels[index]):")
                                .foregroundColor(.primary)
                                .font(.headline)
                            Spacer()
                            Text("\(ratings[index]) people")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RateAppScreen_Previews: PreviewProvider {
    static var previews: some View {
        RateAppScreen(ratings: .constant([0, 0, 0, 0, 0])) // Example preview with sample data
    }
}
