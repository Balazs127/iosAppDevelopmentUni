//
//  SearchBarView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 16/02/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 17, weight: .medium))
            
            TextField("Search books...", text: $text)
                .focused($isFocused)
                .font(.system(size: 17))
                .foregroundColor(.white)
                .accentColor(.blue)
                .textFieldStyle(.plain)
                .submitLabel(.search)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    VStack(spacing: 20) {
        SearchBarView(text: .constant(""))
        SearchBarView(text: .constant("Harry Potter"))
    }
    .padding()
    .background(Color.black)
}
