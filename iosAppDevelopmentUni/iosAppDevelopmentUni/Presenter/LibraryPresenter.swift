//
//  LibraryPresenter.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//
import SwiftUI
import SwiftData

class LibraryPresenter: ObservableObject {
    @Published var searchText: String = ""
    @Published var books: [Book] = []
    @Published var sortPresenter = SortPresenter()
    
    private let dataController = BookDataController.shared
    
    func processBooks(from allBooks: [Book]) {
        var result = allBooks

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }

        result = sortPresenter.sortBooks(books: result)

        books = result
    }

    func fetchBooks() {
        books = dataController.fetchBooks()
    }

    func addBook(title: String, author: String) {
        dataController.addBook(title: title, author: author)
        fetchBooks()
    }

    func deleteBook(_ book: Book) {
        dataController.deleteBook(book)
        fetchBooks()
    }
}
