//
//  FilterSheetPresenter.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

class FilterPresenter: ObservableObject {
    @Published var filterText: String = ""
    @Published var selectedFilterCriteria: FilterCriteria = .title

    func filterBooks(books: [Book]) -> [Book] {
        guard !filterText.isEmpty else { return books }
        
        switch selectedFilterCriteria {
        case .title:
            return books.filter { $0.title.localizedCaseInsensitiveContains(filterText) }
        case .author:
            return books.filter { $0.author.localizedCaseInsensitiveContains(filterText) }
        }
    }
}
