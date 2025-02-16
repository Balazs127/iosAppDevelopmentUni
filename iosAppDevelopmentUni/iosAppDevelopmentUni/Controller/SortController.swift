//
//  SortController.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

enum SortOption: CaseIterable, Identifiable {
    case titleAscending, titleDescending, authorAscending, authorDescending
    
    var id: String { rawValue }
    
    var rawValue: String {
        switch self {
        case .titleAscending: return "Title (A-Z)"
        case .titleDescending: return "Title (Z-A)"
        case .authorAscending: return "Author (A-Z)"
        case .authorDescending: return "Author (Z-A)"
        }
    }
    
    var icon: String {
        switch self {
        case .titleAscending: return "arrow.up"
        case .titleDescending: return "arrow.down"
        case .authorAscending: return "person.fill.badge.plus"
        case .authorDescending: return "person.fill.badge.minus"
        }
    }

    var sortIcon: String {
        switch self {
        case .titleAscending, .authorAscending: return "chevron.up"
        case .titleDescending, .authorDescending: return "chevron.down"
        }
    }
}

class SortController: ObservableObject {
    @Published var selectedSortOption: SortOption = .titleAscending

    func sortBooks(books: [Book]) -> [Book] {
        books.sorted { book1, book2 in
            switch selectedSortOption {
            case .titleAscending:
                return book1.title < book2.title
            case .titleDescending:
                return book1.title > book2.title
            case .authorAscending:
                return book1.author < book2.author
            case .authorDescending:
                return book1.author > book2.author
            }
        }
    }
}
