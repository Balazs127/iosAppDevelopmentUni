//
//  SortPresenter.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

enum SortOption: String, CaseIterable, Identifiable {
    case titleAscending = "Title ↑"
    case titleDescending = "Title ↓"
    case authorAscending = "Author ↑"
    case authorDescending = "Author ↓"
    
    var id: String { rawValue }
}

class SortPresenter: ObservableObject {
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
