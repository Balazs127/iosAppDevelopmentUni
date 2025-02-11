//
//  ContentView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allBooks: [Book]

    @StateObject private var homePresenter = HomePresenter()
    
    @State private var isShowingAddBook = false
    @State private var isSearchActive = false
    @State private var editingBook: Book? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {
                    if isSearchActive {
                        HStack {
                            SearchBar(text: $homePresenter.searchText)
                                .onChange(of: homePresenter.searchText) {
                                    homePresenter.processBooks(from: allBooks)
                                }
                            Button("Cancel") {
                                homePresenter.searchText = ""
                                homePresenter.processBooks(from: allBooks)
                                isSearchActive = false
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        HStack {
                            Text("Home")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                withAnimation { isSearchActive = true }
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack(spacing: 10) {
                        Text("Sort by:")
                            .foregroundColor(.white)
                        Picker("Sort By", selection: $homePresenter.sortPresenter.selectedSortOption) {
                            ForEach(SortOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: homePresenter.sortPresenter.selectedSortOption) {
                            homePresenter.processBooks(from: allBooks)
                        }
                    }
                    .padding(.horizontal)
                    
                    List {
                        ForEach(homePresenter.books, id: \.id) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                BookRowView(book: book)
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.black)
                            .swipeActions(edge: .leading) {
                                Button {
                                    editingBook = book
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.yellow)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    homePresenter.deleteBook(book)
                                    homePresenter.processBooks(from: allBooks)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.black)
                    .padding(.leading, 18)
                    
                    Button(action: { isShowingAddBook = true }) {
                        Text("Add New Book")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 80)
            }
            .sheet(item: $editingBook) { book in
                EditBookView(book: book)
            }
            .sheet(isPresented: $isShowingAddBook) {
                AddBookView()
                    .onDisappear {
                        homePresenter.fetchBooks()
                        homePresenter.processBooks(from: allBooks)
                    }
            }
            .overlay(BottomNavBar(), alignment: .bottom)
            .onAppear {
                homePresenter.fetchBooks()
                homePresenter.processBooks(from: allBooks)
                BookDataController.shared.setModelContext(modelContext)
            }
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let sampleBooks: [Book] = getSampleBooks()
        sampleBooks.forEach { container.mainContext.insert($0) }

        return HomeView()
            .modelContainer(container)
        
    } catch {
        fatalError("Failed to create in-memory container: \(error)")
    }
}
