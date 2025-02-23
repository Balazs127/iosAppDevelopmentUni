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
    @State private var selectedGenre: BookGenre
    @State private var totalPages: String
    @State private var pagesRead: String
    
    let book: Book
    private let dataController = BookDataController.shared
    @FocusState private var focusedField: Field?
    
    init(book: Book) {
        self.book = book
        _title = State(initialValue: book.title)
        _author = State(initialValue: book.author)
        _bookDescription = State(initialValue: book.bookDescription)
        _rating = State(initialValue: book.rating)
        _selectedGenre = State(initialValue: BookGenre.allCases.first(where: { $0.rawValue == book.genre }) ?? .unknown)
        _totalPages = State(initialValue: String(book.totalPages))
        _pagesRead = State(initialValue: String(book.pagesRead))
    }
    
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
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Genre*")
                        .foregroundColor(Color.secondary)
                        .fontWeight(.semibold)
                    Picker("Select a genre", selection: $selectedGenre) {
                        ForEach(BookGenre.allCases, id: \.self) { item in
                            Text(item.rawValue).tag(item)
                        }
                    }
                    .foregroundColor(.secondary)
                    .pickerStyle(.menu)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    )
                }
                .padding(.vertical, 4)
                .listRowSeparator(.hidden)
                
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
                
                LabeledField(
                    label: "Pages Read",
                    placeholder: "Enter pages read",
                    text: $pagesRead,
                    keyboardType: .numberPad,
                    focus: $focusedField,
                    field: .pagesRead
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
                
                if let total = Int(totalPages), let read = Int(pagesRead), total > 0 {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Reading Progress")
                            .foregroundColor(.secondary)
                        ProgressView(value: Double(read), total: Double(total))
                            .tint(.orange)
                        Text("\(Int((Double(read)/Double(total))*100))% Complete")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                    .listRowSeparator(.hidden)
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Edit Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                    .disabled(selectedGenre.rawValue == "Unknown" || title.isEmpty || totalPages.isEmpty || (Int(totalPages) ?? 0) == 0)
                    .foregroundColor((selectedGenre.rawValue == "Unknown" || title.isEmpty || totalPages.isEmpty || (Int(totalPages) ?? 0) == 0) ? .gray : .blue)
                    .opacity((selectedGenre.rawValue == "Unknown" || title.isEmpty || totalPages.isEmpty || (Int(totalPages) ?? 0) == 0) ? 0.5 : 1.0)
                    .animation(.easeInOut, value: title.isEmpty)
                }
            }
            .onTapGesture { 
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), 
                    to: nil, from: nil, for: nil)
            }
        }
    }
    
    private func saveChanges() {
        book.title = title
        book.author = author
        book.bookDescription = bookDescription
        book.rating = rating
        book.genre = selectedGenre.rawValue
        book.totalPages = Int(totalPages) ?? 0
        book.pagesRead = Int(pagesRead) ?? 0
        
        dataController.saveContext()
        dismiss()
    }
}

#Preview {
    EditBookView(book: sampleBooks[1])
}

