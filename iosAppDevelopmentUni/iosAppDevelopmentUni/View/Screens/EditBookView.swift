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

    let book: Book
    private let dataController = BookDataController.shared

    init(book: Book) {
        self.book = book
        _title = State(initialValue: book.title)
        _author = State(initialValue: book.author)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Edit Book")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
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
        dataController.saveContext()
        dismiss()
    }
}

#Preview {
    EditBookView(book: Book(title: "Sample Book", author: "Sample Author"))
}

