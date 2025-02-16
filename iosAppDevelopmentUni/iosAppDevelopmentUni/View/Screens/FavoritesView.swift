//
//  FavoritesView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 11/02/2025.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                Text("Favorites")
                    .foregroundColor(.white)
            }
            .navigationTitle("Favorites")
        }
    }
}
