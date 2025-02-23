//
//  BookDataContorller.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 08/02/2025.
//

import SwiftData
import SwiftUI

class BookDataController {
    static let shared = BookDataController()

    private var modelContext: ModelContext?

    private init() {}  // Prevent direct instantiation

    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
        initializeWithSampleBooksIfEmpty()
    }

    func initializeWithSampleBooksIfEmpty() {
        guard let modelContext = modelContext else { return }
        
        let books = fetchBooks()
        if books.isEmpty {
            sampleBooks.forEach { book in
                modelContext.insert(book)
            }
            saveContext()
        }
    }

    func fetchBooks() -> [Book] {
        guard let modelContext = modelContext else { return [] }
        do {
            return try modelContext.fetch(FetchDescriptor<Book>())
        } catch {
            print("Failed to fetch books: \(error)")
            return []
        }
    }

    func saveContext() {
        guard let modelContext = modelContext else { return }
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    func addBook(
        title: String,
        author: String,
        bookDescription: String,
        rating: Double,
        isSaved: Bool = false,
        genre: String,
        totalPages: Int
    ) {
        guard let modelContext = modelContext, !title.isEmpty else { return }
        let newBook = Book(
            title: title,
            author: author,
            bookDescription: bookDescription,
            rating: rating,
            isSaved: isSaved,
            genre: genre,
            totalPages: totalPages,
            pagesRead: 0,
            userReview: ""
        )
        modelContext.insert(newBook)
        saveContext()
    }

    func deleteBook(_ book: Book) {
        guard let modelContext = modelContext else { return }
        modelContext.delete(book)
        saveContext()
    }

    func insertSampleBooks() {
        guard let modelContext = modelContext else { return }

        let books = fetchBooks()
        guard books.isEmpty else { return }

        let sampleBooks: [Book] = getSampleBooks()

        for book in sampleBooks {
            modelContext.insert(book)
        }
        saveContext()
    }
}
