//
//  Book.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//
//
//import Foundation
//
//struct Book: Identifiable {
//    let id = UUID()
//    let title: String
//    let author: String
//}
//

import SwiftUI
import SwiftData

@Model
class Book {
    var id: UUID
    var title: String = ""
    var author: String = ""
    var bookDescription: String
    var rating: Double
    var isSaved: Bool
    var genre: String
    var totalPages: Int
    var pagesRead: Int = 0
    var dateAdded: Date
    
    init(title: String, author: String, bookDescription: String, rating: Double, isSaved: Bool = false, genre: String, totalPages: Int, pagesRead: Int) {
        self.id = UUID()
        self.title = title
        self.author = author
        self.bookDescription = bookDescription
        self.rating = rating
        self.isSaved = isSaved
        self.genre = genre
        self.totalPages = totalPages
        self.pagesRead = pagesRead
        self.dateAdded = Date()
    }
    
//    func toggleSaved() {
//        isSaved.toggle()
//    }
//    
//    func updateProgress(pagesRead: Int) {
//        self.pagesRead = min(max(0, pagesRead), totalPages)
//    }
//    
//    func getProgressPercentage() -> Double {
//        return Double(pagesRead) / Double(totalPages) * 100
//    }
//    
//    func getRemainingPages() -> Int {
//        return totalPages - pagesRead
//    }
}
