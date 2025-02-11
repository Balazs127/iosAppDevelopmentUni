//
//  BottomNavBar.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct BottomNavBar: View {
    var body: some View {
        HStack {
            BottomNavItem(icon: "house.fill", label: "Home")
            BottomNavItem(icon: "heart.fill", label: "Book")
            BottomNavItem(icon: "person.fill", label: "Account")
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(
            Color.gray.opacity(0.2)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

#Preview {
    BottomNavBar()
        .background(Color.black)
}
