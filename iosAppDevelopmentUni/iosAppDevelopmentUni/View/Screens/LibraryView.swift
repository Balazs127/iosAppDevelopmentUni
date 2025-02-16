//
//  LibraryView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allBooks: [Book]

    @StateObject private var libraryPresenter = LibraryPresenter()
    
    @State private var isShowingAddBook = false
    @State private var isSearchActive = false
    @State private var editingBook: Book? = nil
    @State private var isGridView = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {
                    LibraryHeaderView(
                        isSearchActive: $isSearchActive,
                        searchText: $libraryPresenter.searchText,
                        onSearchChange: { libraryPresenter.processBooks(from: allBooks) }
                    )
                    
                    SortingToolbarView(
                        selectedSortOption: $libraryPresenter.sortPresenter.selectedSortOption,
                        isGridView: $isGridView,
                        onSortChange: { libraryPresenter.processBooks(from: allBooks) }
                    )
                    
                    BookCollectionView(
                        books: libraryPresenter.books,
                        isGridView: isGridView,
                        onEdit: { book in editingBook = book },
                        onDelete: { book in libraryPresenter.deleteBook(book) }
                    )
                }
                
                FloatingActionButton(action: { isShowingAddBook = true })
            }
            .sheet(item: $editingBook) { book in
                EditBookView(book: book)
            }
            .sheet(isPresented: $isShowingAddBook) {
                AddBookView()
                    .onDisappear {
                        libraryPresenter.fetchBooks()
                        libraryPresenter.processBooks(from: allBooks)
                    }
            }
            .onAppear {
                libraryPresenter.fetchBooks()
                libraryPresenter.processBooks(from: allBooks)
                BookDataController.shared.setModelContext(modelContext)
            }
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

        let sampleBooks: [Book] = getSampleBooks()
        sampleBooks.forEach { container.mainContext.insert($0) }

        return MainTabView()
            .modelContainer(container)

    } catch {
        fatalError("Failed to create in-memory container: \(error)")
    }
}
