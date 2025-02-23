//
//  BookCollectionView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 16/02/2025.
//

import SwiftUI

struct BookCollectionView: View {
    var books: [Book]
    var isGridView: Bool
    var onEdit: (Book) -> Void
    var onDelete: (Book) -> Void
    
    var body: some View {
        ScrollView {
            if isGridView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 160), spacing: 20)],
                    spacing: 20
                ) {
                    ForEach(books) { book in
                        bookLink(for: book, isGridView: true)
                            .frame(height: 200)
                    }
                }
                .padding(.horizontal)
            } else {
                LazyVStack(spacing: 15) {
                    ForEach(books) { book in
                        bookLink(for: book, isGridView: false)
                            .frame(maxWidth: .infinity, maxHeight: 80)
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
    }
    
    private func bookLink(for book: Book, isGridView: Bool) -> some View {
        NavigationLink(destination: BookDetailView(book: book)) {
            BookButtonView(
                book: book,
                onEdit: { onEdit(book) },
                onDelete: { onDelete(book) },
                isGridView: isGridView
            )
        }
    }
}

#Preview {
    NavigationView {
        VStack(spacing: 20) {
            BookCollectionView(
                books: Array(sampleBooks.prefix(2)),
                isGridView: true,
                onEdit: { _ in print("Edit") },
                onDelete: { _ in print("Delete") }
            )
            
            BookCollectionView(
                books: Array(sampleBooks.prefix(2)),
                isGridView: false,
                onEdit: { _ in print("Edit") },
                onDelete: { _ in print("Delete") }
            )
        }
        .navigationTitle("Books")
    }
}
