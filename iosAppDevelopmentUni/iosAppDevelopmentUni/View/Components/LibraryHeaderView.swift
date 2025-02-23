//
//  LibraryHeaderView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 16/02/2025.
//

import SwiftUI

struct LibraryHeaderView: View {
    @Binding var isSearchActive: Bool
    @Binding var searchText: String
    @FocusState private var isSearchFieldFocused: Bool
    var onSearchChange: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            if !isSearchActive {
                Text("Library")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
            
            if isSearchActive {
                SearchBarView(text: $searchText, isFocused: _isSearchFieldFocused)
                    .onChange(of: searchText, onSearchChange)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                Spacer()
            }
            
            HStack(spacing: 8) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isSearchActive.toggle()
                        if isSearchActive {
                            isSearchFieldFocused = true
                        }
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                
                if !isSearchActive {
                    ProfileButton()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
                
                if isSearchActive {
                    Button("Cancel") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            searchText = ""
                            isSearchActive = false
                            onSearchChange()
                        }
                    }
                    .foregroundColor(Color.accentColor.opacity(0.8))
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ProfileButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor.opacity(0.8))
                .frame(width: 40, height: 40)
            
            Text("BK")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        LibraryHeaderView(
            isSearchActive: .constant(false),
            searchText: .constant(""),
            onSearchChange: {}
        )
        
        LibraryHeaderView(
            isSearchActive: .constant(true),
            searchText: .constant("Harry Potter"),
            onSearchChange: {}
        )
    }
    .padding()
}
