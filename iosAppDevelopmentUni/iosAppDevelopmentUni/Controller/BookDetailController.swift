//
//  BookDetailContorller.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 08/02/2025.
//

import SwiftUI

class BookDetailController: ObservableObject {
    @Published var book: Book
    @Published var readingProgress: Double
    @Published var isRead: Bool
    @Published var bookNotes: String
    @Published var rating: Int
    @Published var previousProgress: Double
    
    init(book: Book) {
        self.book = book
        self.readingProgress = Double(book.pagesRead) / Double(book.totalPages) * 100
        self.isRead = book.pagesRead == book.totalPages
        self.bookNotes = book.userReview
        self.rating = Int(book.rating)
        self.previousProgress = Double(book.pagesRead) / Double(book.totalPages) * 100
    }
    
    func updateBookProgress() {
        let newPagesRead = Int((readingProgress / 100) * Double(book.totalPages))
        book.pagesRead = newPagesRead
        BookDataController.shared.saveContext()
    }
    
    func updateBookReview() {
        book.userReview = bookNotes
        book.rating = Double(rating)
        BookDataController.shared.saveContext()
    }
    
    func refreshViewState() {
        readingProgress = Double(book.pagesRead) / Double(book.totalPages) * 100
        isRead = book.pagesRead == book.totalPages
        bookNotes = book.userReview
        rating = Int(book.rating)
    }
    
    func handleMarkAsRead(newValue: Bool) {
        if newValue {
            previousProgress = readingProgress
            readingProgress = 100
            book.pagesRead = book.totalPages
        } else {
            readingProgress = previousProgress
            book.pagesRead = Int((previousProgress / 100) * Double(book.totalPages))
        }
        BookDataController.shared.saveContext()
    }
    
    func deleteBook() {
        BookDataController.shared.deleteBook(book)
    }
}
