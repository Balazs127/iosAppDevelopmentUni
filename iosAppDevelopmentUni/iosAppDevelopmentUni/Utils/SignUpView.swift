//
//  SignUpView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct SignUpView: View {
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Create an Account")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Sign up to start tracking your books!")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                    .navigationDestination(isPresented: $navigateToHome) {
                        HomeView()
                    }
                
                Button(action: {
                    navigateToHome = true
                    print("Sign-Up Form Submitted")
                }) {
                    Text("Continue")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
            }
            .padding()
        }
    }
}


#Preview {
    SignUpView()
}
