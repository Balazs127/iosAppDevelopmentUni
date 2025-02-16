//
//  EditBookView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 08/02/2025.
//

import SwiftUI
import SwiftData

struct EditBookView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String
    @State private var author: String
    @State private var bookDescription: String
    @State private var rating: Double
    @State private var genre: String
    @State private var totalPages: String
    @State private var pagesRead: String
    @State private var isSaved: Bool

    let book: Book
    private let dataController = BookDataController.shared

    init(book: Book) {
        self.book = book
        _title = State(initialValue: book.title)
        _author = State(initialValue: book.author)
        _bookDescription = State(initialValue: book.bookDescription)
        _rating = State(initialValue: book.rating)
        _genre = State(initialValue: book.genre)
        _totalPages = State(initialValue: String(book.totalPages))
        _pagesRead = State(initialValue: String(book.pagesRead))
        _isSaved = State(initialValue: book.isSaved)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    TextField("Genre", text: $genre)
                    TextField("Description", text: $bookDescription, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section(header: Text("Book Information")) {
                    TextField("Total pages", text: $totalPages)
                        .keyboardType(.numberPad)
                    TextField("Pages read", text: $pagesRead)
                        .keyboardType(.numberPad)
                    
                    VStack {
                        Text("Rating: \(rating, specifier: "%.1f")")
                        Slider(value: $rating, in: 0...5, step: 0.1)
                    }
                    
                    Toggle("Save to Library", isOn: $isSaved)
                }
                
                if let total = Int(totalPages), let read = Int(pagesRead), total > 0 {
                    Section(header: Text("Reading Progress")) {
                        ProgressView(value: Double(read), total: Double(total))
                        Text("\(Int((Double(read)/Double(total))*100))% Complete")
                    }
                }
            }
            .navigationTitle("Edit Book")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveChanges() {
        book.title = title
        book.author = author
        book.bookDescription = bookDescription
        book.rating = rating
        book.genre = genre
        book.totalPages = Int(totalPages) ?? 0
        book.pagesRead = Int(pagesRead) ?? 0
        book.isSaved = isSaved
        
        dataController.saveContext()
        dismiss()
    }
}

#Preview {
    EditBookView(book: sampleBooks[1])
}

