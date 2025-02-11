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

    private let dataController = BookDataController.shared
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Enter book title", text: $title)
                        .textInputAutocapitalization(.words)
                    TextField("Enter author name", text: $author)
                        .textInputAutocapitalization(.words)
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
        dataController.addBook(title: title, author: author.isEmpty ? "Unknown Author" : author)
        dismiss()
    }
}

#Preview {
    AddBookView()
}
