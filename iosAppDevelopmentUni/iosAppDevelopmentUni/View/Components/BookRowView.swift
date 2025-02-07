//
//  BookRowView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct BookRowView: View {
    var book: Book

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "book.fill")
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
    }
}
