//
//  BookDetailView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct BookDetailView: View {
    @StateObject private var controller: BookDetailController
    @Environment(\.dismiss) private var dismiss
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    @FocusState private var focusedField: Field?
    
    init(book: Book) {
        _controller = StateObject(wrappedValue: BookDetailController(book: book))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 16) {
                    HStack(alignment: .top, spacing: 20) {
                        AsyncImage(url: URL(string: "https://")) { image in // Placeholder if book image url is implemented
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "book.closed.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .foregroundColor(.blue)
                        }
                        .frame(width: 130, height: 130)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text(controller.book.title)
                                .font(.system(size: 24, weight: .bold))
                            
                            Text("By \(controller.book.author)")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                
                            if !controller.book.genre.isEmpty {
                                Text("Genre: \(controller.book.genre)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                                
                            Text("Added: \(controller.book.dateAdded.formatted(date: .abbreviated, time: .omitted))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Reading Progress")
                            .font(.headline)
                        
                        NavigationLink(destination: ReadingView(book: controller.book, onDismiss: {
                            controller.refreshViewState()
                        })) {
                            HStack {
                                Image(systemName: "book.pages")
                                Text("Continue Reading")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .padding(.vertical, 8)
                        
                        Slider(value: $controller.readingProgress, in: 0...100, step: 1)
                            .tint(.blue)
                            .frame(height: 30)
                            .onChange(of: controller.readingProgress) { 
                                controller.updateBookProgress()
                                controller.isRead = controller.readingProgress == 100
                            }
                        
                        Text(String(format: "%.0f%% Complete", controller.readingProgress))
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Toggle("Mark as Read", isOn: $controller.isRead)
                                .tint(.green)
                                .onChange(of: controller.isRead) { oldValue, newValue in
                                    controller.handleMarkAsRead(newValue: newValue)
                                }
                            
                            if controller.isRead {
                                Text("Progress will be set to 100%")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Text("Changes are automatically saved")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        LabeledField(
                            label: "Your Review",
                            placeholder: "Write your thoughts about the book...",
                            text: $controller.bookNotes,
                            axis: .vertical,
                            focus: $focusedField,
                            field: .description
                        )
                        .onChange(of: controller.bookNotes) { controller.updateBookReview() }
                        
                        HStack(spacing: 4) {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= controller.rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        controller.rating = star
                                        controller.updateBookReview()
                                    }
                            }
                        }
                        .padding(.leading, 4)
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding(.bottom, 80)
            }
            
            VStack {
                HStack(spacing: 20) {
                    Button(action: { showingEditSheet = true }) {
                        Label("Edit", systemImage: "pencil")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: { showingDeleteAlert = true }) {
                        Label("Delete", systemImage: "trash")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color.gray.opacity(0.1))
            }
            .opacity(focusedField == .description ? 0 : 1)
            .animation(.easeInOut(duration: 0.2), value: focusedField)
        }
        .background(Color(uiColor: .systemBackground))
        .animation(.easeOut(duration: 0.2), value: focusedField)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                controller.deleteBook()
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this book?")
        }
        .sheet(isPresented: $showingEditSheet) {
            EditBookView(book: controller.book)
                .onDisappear {
                    controller.refreshViewState()
                }
        }
        .onTapGesture { 
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), 
                to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    BookDetailView(book: sampleBooks[1])
}
