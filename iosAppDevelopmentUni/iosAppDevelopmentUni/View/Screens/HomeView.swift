//
//  ContentView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homePresenter = HomePresenter()
    @StateObject private var filterPresenter = FilterPresenter()
    @StateObject private var sortPresenter = SortPresenter()

    @State private var isShowingAddBook = false
    @State private var isSearchActive = false
    @State private var showingSortSheet = false
    @State private var showingFilterSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {
                    // Top Bar
                    HStack {
                        Text("Home")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        if !isSearchActive {
                            Button(action: {
                                withAnimation { isSearchActive = true }
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    // Conditional Search Bar or Welcome Text
                    if isSearchActive {
                        HStack {
                            SearchBar(text: $homePresenter.searchText)
                            Button("Cancel") {
                                withAnimation {
                                    isSearchActive = false
                                    homePresenter.searchText = ""
                                }
                            }
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                    } else {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Welcome to")
                                .font(.title3)
                                .foregroundColor(.gray)
                            Text("BookTrack")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }

                    // Sorting & Filtering Buttons
                    HStack(spacing: 10) {
                        ModernButton(title: "Sort", iconName: "arrow.up.arrow.down") {
                            showingSortSheet = true
                        }
                        ModernButton(title: "Filter", iconName: "line.horizontal.3.decrease.circle") {
                            showingFilterSheet = true
                        }
                    }
                    .padding(.horizontal)

                    // Book List
                    List {
                        ForEach(filteredBooks) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                BookRowView(book: book)
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.black)
                        }
                        .padding(.bottom, 10)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.black)
                    .padding(.leading, 18)

                    // Add New Book Button
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
            .navigationDestination(isPresented: $isShowingAddBook) {
                AddBookView()
            }
            .overlay(BottomNavBar(), alignment: .bottom)
            .sheet(isPresented: $showingSortSheet) {
                SortSheetView(presenter: sortPresenter)
            }
            .sheet(isPresented: $showingFilterSheet) {
                FilterSheetView(presenter: filterPresenter)
            }
        }
    }

    private var filteredBooks: [Book] {
        let filtered = filterPresenter.filterBooks(books: homePresenter.books)
        return sortPresenter.sortBooks(books: filtered)
    }
}
