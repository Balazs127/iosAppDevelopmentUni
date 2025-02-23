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

enum BookGenre: String, CaseIterable {
    case unknown = "Unknown"
    case fantasy = "Fantasy"
    case scienceFiction = "Science Fiction"
    case mystery = "Mystery"
    case romance = "Romance"
    case thriller = "Thriller"
    case historicalFiction = "Historical Fiction"
    case nonFiction = "Non-Fiction"
    case contemporary = "Contemporary"
}

import SwiftUI
import SwiftData

@Model
class Book {
    var id: UUID
    var title: String = ""
    var author: String = ""
    var bookDescription: String = ""
    var rating: Double
    var isSaved: Bool
    var genre: String
    var totalPages: Int
    var pagesRead: Int = 0
    var dateAdded: Date
    var userReview: String = ""
    
    init(title: String, author: String, bookDescription: String, rating: Double, isSaved: Bool = false, genre: String, totalPages: Int, pagesRead: Int, userReview: String) {
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
        self.userReview = userReview
    }
    
    func getProgressPercentage() -> Double {
        return Double(pagesRead) / Double(totalPages) * 100
    }
}
