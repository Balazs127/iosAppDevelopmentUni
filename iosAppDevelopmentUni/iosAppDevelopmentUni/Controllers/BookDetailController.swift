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
        self.bookNotes = book.userReview
        self.rating = Int(max(0, min(5, book.rating)))
        
        // Calculate initial values before assigning to properties
        let totalPages = max(1, book.totalPages)
        let pagesRead = max(0, min(book.pagesRead, totalPages))
        let progress = book.getProgressPercentage()
        
        self.readingProgress = progress
        self.previousProgress = progress
        self.isRead = pagesRead == totalPages
    }
    
    func updateBookProgress() {
        let totalPages = max(1, book.totalPages)
        let newPagesRead = Int((readingProgress / 100) * Double(totalPages))
        book.pagesRead = max(0, min(newPagesRead, totalPages))
        BookDataController.shared.saveContext()
    }
    
    func updateBookReview() {
        book.userReview = bookNotes
        book.rating = Double(min(5, max(0, rating)))
        BookDataController.shared.saveContext()
    }
    
    func refreshViewState() {
        bookNotes = book.userReview
        rating = Int(max(0, min(5, book.rating)))
        
        let totalPages = max(1, book.totalPages)
        let pagesRead = max(0, min(book.pagesRead, totalPages))
        
        readingProgress = book.getProgressPercentage()
        isRead = pagesRead == totalPages
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
