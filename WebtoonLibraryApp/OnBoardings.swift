//
//  OnBoardings.swift
//  WebtoonLibraryApp
//
//  Created by Nakshatra Verma on 11/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentIndex = 0
    @Binding var showOnboarding: Bool
    @State private var showSignIn = false  // To trigger the navigation to SignInView
    
    let onboardingScreens = [
        OnboardingScreen(imageName: "anime_featured", title: "Featured Anime", description: "Discover trending anime and new releases!"),
        OnboardingScreen(imageName: "anime_recommend", title: "Recommendations", description: "Get personalized anime suggestions based on your taste."),
        OnboardingScreen(imageName: "anime_news", title: "News & Reviews", description: "Stay updated with the latest news and honest reviews.")
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<onboardingScreens.count) { index in
                    VStack {
                        Image(onboardingScreens[index].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                        
                        Text(onboardingScreens[index].title)
                            .font(.title)
                            .padding(.top, 20)
                        
                        Text(onboardingScreens[index].description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.top, 10)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .padding(.top, 50)
            
            Button(action: {
                if currentIndex < onboardingScreens.count - 1 {
                    currentIndex += 1
                } else {
                    showSignIn = true  // Dismiss onboarding when finished
                }
            }) {
                Text(currentIndex == onboardingScreens.count - 1 ? "Get Started" : "Next")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
            }
            .padding(.top, 20)
        }
        .fullScreenCover(isPresented: $showSignIn) {
                    SignInView()
                }
    }
}

struct OnboardingScreen {
    let imageName: String
    let title: String
    let description: String
}

struct semiMainView: View {
    @State private var showOnboarding = true  // State to control the onboarding flow
    
    var body: some View {
        if showOnboarding {
            OnboardingView(showOnboarding: $showOnboarding)  // Pass the binding to OnboardingView
        } else {
            SignInView()  // Show SignInView after onboarding completes
        }
    }
}

struct semiMainView_Previews: PreviewProvider {
    static var previews: some View {
        semiMainView()
    }
}
