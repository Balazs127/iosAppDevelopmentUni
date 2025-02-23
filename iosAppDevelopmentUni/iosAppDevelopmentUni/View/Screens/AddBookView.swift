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
    
    private let dataController = BookDataController.shared
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledField(
                    label: "Title",
                    placeholder: "Enter book title",
                    text: $title,
                    isRequired: true,
                    focus: $focusedField,
                    field: .title
                )
                
                LabeledField(
                    label: "Author",
                    placeholder: "Enter author name",
                    text: $author,
                    focus: $focusedField,
                    field: .author
                )
                
                LabeledField(
                    label: "Genre",
                    placeholder: "Enter genre",
                    text: $genre,
                    focus: $focusedField,
                    field: .genre
                )
                
                LabeledField(
                    label: "Description",
                    placeholder: "Enter description",
                    text: $bookDescription,
                    axis: .vertical,
                    focus: $focusedField,
                    field: .description
                )
                
                LabeledField(
                    label: "Total Pages",
                    placeholder: "Enter number of pages",
                    text: $totalPages,
                    isRequired: true,
                    keyboardType: .numberPad,
                    focus: $focusedField,
                    field: .pages
                )
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Rating: \(rating, specifier: "%.1f")")
                        .foregroundColor(.secondary)
                    HStack {
                        Text("0 ⭐").foregroundColor(.secondary)
                        Slider(value: $rating, in: 0...5, step: 0.5)
                            .tint(.orange)
                            .padding(.horizontal, 8)
                        Text("5 ⭐").foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Add New Book")
            .padding(.top, 8)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveBook()
                        dismiss()
                    }
                    .disabled(title.isEmpty || totalPages.isEmpty || totalPages == "0")
                    .foregroundColor((title.isEmpty || totalPages.isEmpty || totalPages == "0") ? .gray : .blue)
                    .opacity((title.isEmpty || totalPages.isEmpty || totalPages == "0") ? 0.5 : 1.0)
                    .animation(.easeInOut, value: title.isEmpty)
                }
            }
            .onTapGesture { 
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), 
                    to: nil, from: nil, for: nil)
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
            isSaved: true,
            genre: genre,
            totalPages: pages
        )
        dismiss()
    }
}

#Preview {
    AddBookView()
}
