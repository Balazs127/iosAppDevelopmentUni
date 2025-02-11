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
    var dateAdded: Date
    
    init(title: String, author: String) {
        self.id = UUID()
        self.title = title
        self.author = author
        self.dateAdded = Date()
    }
}
