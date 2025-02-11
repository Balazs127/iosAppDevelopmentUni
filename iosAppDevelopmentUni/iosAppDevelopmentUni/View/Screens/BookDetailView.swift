//
//  BookDetailView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book

    var body: some View {
        VStack {
            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
            Text("Author: \(book.author)")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    BookDetailView(book: .init(title: "Test", author: "Test"))
}