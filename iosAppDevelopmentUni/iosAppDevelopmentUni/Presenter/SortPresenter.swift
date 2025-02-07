//
//  SortPresenter.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

class SortPresenter: ObservableObject {
    @Published var selectedSortOption: SortOption = .title
    @Published var sortAscending: Bool = true

    func sortBooks(books: [Book]) -> [Book] {
        books.sorted { book1, book2 in
            switch selectedSortOption {
            case .title:
                return sortAscending ? (book1.title < book2.title) : (book1.title > book2.title)
            case .author:
                return sortAscending ? (book1.author < book2.author) : (book1.author > book2.author)
            }
        }
    }
}
