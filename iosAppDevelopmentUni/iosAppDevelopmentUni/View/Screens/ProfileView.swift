//
//  ProfileView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 11/02/2025.
//
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                Text("Profile")
                    .foregroundColor(.white)
            }
            .navigationTitle("Profile")
        }
    }
}
