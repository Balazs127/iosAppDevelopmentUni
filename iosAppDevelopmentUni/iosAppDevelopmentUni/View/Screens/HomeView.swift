//
//  HomeView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 11/02/2025.
//
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Text("Home")
                    .foregroundColor(.primary)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
