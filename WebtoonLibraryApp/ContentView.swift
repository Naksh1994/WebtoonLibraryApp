//
//  ContentView.swift
//  WebtoonLibraryApp
//
//  Created by Nakshatra Verma on 11/10/24.
//

// ContentView.swift

import SwiftUI

struct WelcomeView: View {
    @Binding var showOnboarding: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            // App Name in the middle of the screen
            Text("Webtoon Library")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // "Let's Begin" button at the bottom center
            Button(action: {
                showOnboarding = true
            }) {
                Text("Let's Begin")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40) // Adjust bottom padding to position it properly
            
        }
        .edgesIgnoringSafeArea(.all) // Make sure content is full screen
        .background(Color(.systemBackground)) // Background color based on system theme (light/dark)
    }
}

struct ContentView2: View {
    @State private var showOnboarding = false  // Start with false to show WelcomeView first
    var body: some View {
        if showOnboarding {
            OnboardingView(showOnboarding: $showOnboarding)  // Navigate to OnboardingView when showOnboarding is true
        } else {
            WelcomeView(showOnboarding: $showOnboarding)  // Pass the binding to WelcomeView
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
