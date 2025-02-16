//
//  AddBookView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var bookDescription: String = ""
    @State private var rating: Double = 3.0
    @State private var genre: String = ""
    @State private var totalPages: String = ""
    @State private var isSaved: Bool = false

    private let dataController = BookDataController.shared
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Enter book title", text: $title)
                        .textInputAutocapitalization(.words)
                    TextField("Enter author name", text: $author)
                        .textInputAutocapitalization(.words)
                    TextField("Enter genre", text: $genre)
                    TextField("Enter description", text: $bookDescription, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section(header: Text("Book Information")) {
                    TextField("Total pages", text: $totalPages)
                        .keyboardType(.numberPad)
                    
                    VStack {
                        Text("Rating: \(rating, specifier: "%.1f")")
                        Slider(value: $rating, in: 0...5, step: 0.1)
                    }
                    
                    Toggle("Save to Library", isOn: $isSaved)
                }
            }
            .navigationTitle("Add New Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveBook()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }

    private func saveBook() {
        let pages = Int(totalPages) ?? 0
        dataController.addBook(
            title: title,
            author: author.isEmpty ? "Unknown Author" : author,
            bookDescription: bookDescription,
            rating: rating,
            isSaved: isSaved,
            genre: genre,
            totalPages: pages
        )
        dismiss()
    }
}

#Preview {
    AddBookView()
}
