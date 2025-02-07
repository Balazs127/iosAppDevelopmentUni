//
//  ContentView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 02/02/2025.
//

import SwiftUI

struct WelcomeView: View {
    @State private var navigateToHome = false // Controls navigation
    @State private var showSignUp = false // Controls sign-up pop-up

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Image at the top
                Image("illustration-e-book") // Replace with actual asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                
                // Title
                Text("Welcome to BookTrack!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.top, -60)
                    .padding(.horizontal, 20)
                
                // Subtitle
                Text("Manage your book collection with ease. Track your reading progress.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, -40)
                    .padding(.horizontal, 20)
                
                Spacer()

                // Navigation Destination (Fix: Moved outside buttons)
                .navigationDestination(isPresented: $navigateToHome) {
                    HomeView()
                }

                // Get Started Button
                Button(action: {
                    print("Navigating to HomeView") // Debugging
                    navigateToHome = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)

                // Skip Intro Button
                Button(action: {
                    print("Skipping intro") // Debugging
                    navigateToHome = true
                }) {
                    Text("Skip Intro")
                        .foregroundColor(.white)
                }
                
                // Sign-up prompt
                HStack {
                    Text("New user? Register now.")
                        .foregroundColor(.gray)
                    Button(action: {
                        print("Opening Sign-Up") // Debugging
                        showSignUp = true
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding(.bottom, 10)
                .padding(.top, 70)
                .sheet(isPresented: $showSignUp) {
                    SignUpView() // Pop-up Sheet
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}



#Preview {
    WelcomeView()
}
