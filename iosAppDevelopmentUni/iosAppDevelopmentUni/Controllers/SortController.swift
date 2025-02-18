//
//  SortController.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

enum SortOption: CaseIterable, Identifiable {
    case titleAscending, titleDescending, authorAscending, authorDescending, progressAscending, progressDescending
    
    var id: String { rawValue }
    
    var rawValue: String {
        switch self {
        case .titleAscending: return "Title (A-Z)"
        case .titleDescending: return "Title (Z-A)"
        case .authorAscending: return "Author (A-Z)"
        case .authorDescending: return "Author (Z-A)"
        case .progressDescending: return "Progress (100-0)"
        case .progressAscending: return "Progress (0-100)"
        }
    }
    
    var icon: String {
        switch self {
        case .titleAscending: return "arrow.up.circle"
        case .titleDescending: return "arrow.down.circle"
        case .authorAscending: return "person.fill.badge.plus"
        case .authorDescending: return "person.fill.badge.minus"
        case .progressAscending: return "chart.bar.doc.horizontal"
        case .progressDescending: return "chart.bar.doc.horizontal.fill"
        }
    }

    var sortIcon: String {
        switch self {
        case .titleAscending, .authorAscending, .progressAscending: return "chevron.up"
        case .titleDescending, .authorDescending, .progressDescending: return "chevron.down"
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
            case .progressAscending:
                return book1.getProgressPercentage() < book2.getProgressPercentage()
            case .progressDescending:
                return book1.getProgressPercentage() > book2.getProgressPercentage()
            }
            
        }
    }
}
