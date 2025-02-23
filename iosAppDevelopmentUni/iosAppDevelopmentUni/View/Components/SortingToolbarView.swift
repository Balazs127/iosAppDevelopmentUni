//
//  SortingToolbarView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 16/02/2025.
//

import SwiftUI

struct SortingToolbarView: View {
    @Binding var selectedSortOption: SortOption
    @Binding var selectedGenres: [BookGenre]
    @Binding var isGridView: Bool
    var onSortChange: () -> Void
    @State private var isGenrePopoverShown = false
    
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
                    VStack(alignment: .leading) {
                        Text("Sort by")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Text(selectedSortOption.rawValue)
                            .fontWeight(.medium)
                    }
                }
                .foregroundColor(.white)
                .frame(height: 52)
                .padding(.horizontal, 10)
                .background(Color.accentColor.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Button {
                isGenrePopoverShown.toggle()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "tag.circle.fill")
                        .font(.title2)
                    VStack(alignment: .leading) {
                        Text("Filter by")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Text("\(selectedGenres.isEmpty ? "Genre" : "\(selectedGenres.count) selected")")
                            .fontWeight(.medium)
                    }                }
                .foregroundColor(.white)
                .frame(height: 52)
                .padding(.horizontal, 10)
                .background(Color.accentColor.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .popover(isPresented: $isGenrePopoverShown) {
                List(BookGenre.allCases, id: \.self) { genre in
                    Button {
                        if let idx = selectedGenres.firstIndex(of: genre) {
                            selectedGenres.remove(at: idx)
                        } else {
                            selectedGenres.append(genre)
                        }
                        onSortChange()
                    } label: {
                        HStack {
                            Image(systemName: selectedGenres.contains(genre) ? "checkmark.square.fill" : "square")
                                .foregroundStyle(Color.accentColor)
                            Text(genre.rawValue)
                                .foregroundStyle(.primary)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .frame(minWidth: 200)
            }
            
            Spacer()
            
            Button(action: { isGridView.toggle() }) {
                Image(systemName: isGridView ? "square.grid.2x2" : "list.bullet")
                    .foregroundColor(.white)
                    .font(.title3) // Using font to adjust size
                    .fontWeight(.semibold)
                    .frame(width: 52, height: 52)
                    .background(Color.accentColor.opacity(0.7))
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
            selectedGenres: .constant([]),
            isGridView: .constant(true),
            onSortChange: {}
        )
        
        SortingToolbarView(
            selectedSortOption: .constant(.authorDescending),
            selectedGenres: .constant([]),
            isGridView: .constant(false),
            onSortChange: {}
        )
        
        SortingToolbarView(
            selectedSortOption: .constant(.progressAscending),
            selectedGenres: .constant([]),
            isGridView: .constant(true),
            onSortChange: {}
        )
    }
    .padding()
}
