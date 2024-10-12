//
//  RegistrationForm.swift
//  WebtoonLibraryApp
//
//  Created by Nakshatra Verma on 11/10/24.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false
    @State private var isAuthenticated = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign In")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                
                Button(action: {
                    // Authentication logic goes here
                    if email == "test@example.com" && password == "password" {
                        isAuthenticated = true
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)
                
                NavigationLink("Don't have an account? Sign Up", destination: SignUpView())
                    .padding()
                
                Spacer()
            }
            .padding(40)
            .fullScreenCover(isPresented: $isAuthenticated) {
                HomeView() // Replace the welcome text with the Home Screen
                        }
        }
    }
}

struct SignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            
            
            TextField("Name", text: $name)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.bottom, 30)
            
            Button(action: {
                // Sign-up logic goes here
                if password == confirmPassword && !email.isEmpty {
                    // Register user
                }
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)
            
            Spacer()
        }
        .padding()
    }
}

struct MainView: View {
    var body: some View {
        SignInView()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

