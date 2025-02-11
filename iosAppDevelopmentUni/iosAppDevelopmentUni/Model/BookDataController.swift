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

    func addBook(title: String, author: String) {
        guard let modelContext = modelContext, !title.isEmpty else { return }
        let newBook = Book(title: title, author: author)
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
