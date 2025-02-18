//
//  SortingToolbarView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 16/02/2025.
//

import SwiftUI

struct SortingToolbarView: View {
    @Binding var selectedSortOption: SortOption
    @Binding var isGridView: Bool
    var onSortChange: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            Menu {
                ForEach(SortOption.allCases) { option in
                    Button {
                        selectedSortOption = option
                        onSortChange()
                    } label: {
                        Label {
                            Text(option.rawValue)
                        } icon: {
                            HStack(spacing: 4) {
                                Image(systemName: option.icon)
                                Image(systemName: option.sortIcon)
                                    .font(.caption)
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                    
                    VStack(alignment: .leading) {
                        Text("Sort by")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text(selectedSortOption.rawValue)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                    }
                }
                .frame(height: 52)
                .padding(.horizontal, 10)
                .background(Color.blue.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Spacer()
            
            Button(action: { isGridView.toggle() }) {
                Image(systemName: isGridView ? "square.grid.2x2" : "list.bullet")
                    .foregroundColor(.white)
                    .font(.title3) // Using font to adjust size
                    .frame(width: 52, height: 52)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(.horizontal)
    }
}

#Preview("Sorting Toolbar") {
    VStack(spacing: 20) {
        SortingToolbarView(
            selectedSortOption: .constant(.titleAscending),
            isGridView: .constant(true),
            onSortChange: {}
        )
        
        SortingToolbarView(
            selectedSortOption: .constant(.authorDescending),
            isGridView: .constant(false),
            onSortChange: {}
        )
        
        SortingToolbarView(
            selectedSortOption: .constant(.progressAscending),
            isGridView: .constant(true),
            onSortChange: {}
        )
    }
    .padding()
    .background(Color.black)
}
