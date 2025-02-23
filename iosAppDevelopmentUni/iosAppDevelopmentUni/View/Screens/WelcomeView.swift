//
//  WelcomeView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 02/02/2025.
//

import SwiftUI

struct WelcomeView: View {
    @State private var navigateToHome = false
    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Image("illustration-e-book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                
                Text("Welcome to BookTrack!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.top, -60)
                    .padding(.horizontal, 20)
                
                Text("Manage your book collection with ease. Track your reading progress.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, -40)
                    .padding(.horizontal, 20)
                
                Spacer()

                .navigationDestination(isPresented: $navigateToHome) {
                    NavigationStack {
                        MainTabView()       
                    }
                }

                Button(action: {
                    navigateToHome = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)

                Button(action: {
                    navigateToHome = true
                }) {
                    Text("Skip Intro")
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Text("New user? Register now.")
                        .foregroundColor(.secondary)
                    Button(action: {
                        showSignUp = true
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.primary)
                            .bold()
                    }
                }
                .padding(.bottom, 10)
                .padding(.top, 70)
                .sheet(isPresented: $showSignUp) {
                    SignUpView()
                }
            }
            .background(Color(uiColor: .systemBackground))

        }
    }
}

#Preview {
    WelcomeView()
}
