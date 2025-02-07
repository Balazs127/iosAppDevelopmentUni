//
//  HomePresenter.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

enum SortOption: String, CaseIterable, Identifiable {
    case title = "Title"
    case author = "Author"
    var id: String { rawValue }
}

enum FilterCriteria: String, CaseIterable, Identifiable {
    case title = "Title"
    case author = "Author"
    var id: String { rawValue }
}

class HomePresenter: ObservableObject {
    @Published var searchText: String = ""
    @Published var filterText: String = ""
    @Published var selectedFilterCriteria: FilterCriteria = .title
    @Published var selectedSortOption: SortOption = .title
    @Published var sortAscending: Bool = true
    
    var books: [Book] = sampleBooks
    
    var filteredBooks: [Book] {
        var result = books
        
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if !filterText.isEmpty {
            switch selectedFilterCriteria {
            case .title:
                result = result.filter { $0.title.localizedCaseInsensitiveContains(filterText) }
            case .author:
                result = result.filter { $0.author.localizedCaseInsensitiveContains(filterText) }
            }
        }
        
        result.sort { book1, book2 in
            switch selectedSortOption {
            case .title:
                return sortAscending ? (book1.title < book2.title) : (book1.title > book2.title)
            case .author:
                return sortAscending ? (book1.author < book2.author) : (book1.author > book2.author)
            }
        }
        return result
    }
}
