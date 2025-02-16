//
//  BookButtonView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 16/02/2025.
//

import SwiftUI

struct BookButtonView: View {
    var book: Book
    var onEdit: () -> Void
    var onDelete: () -> Void
    @Environment(\.horizontalSizeClass) var sizeClass
    var isGridView: Bool

    var body: some View {
        Group {
            if isGridView {
                gridLayout
            } else {
                listLayout
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(16)
    }
    
    private var gridLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Image(systemName: "book.closed.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue.opacity(0.9))
                    .padding(10)
                
                Spacer(minLength: 0)
                
                menuButton
                    .padding(4)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
        }
    }
    
    private var listLayout: some View {
        HStack {
            Image(systemName: "book.closed.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue.opacity(0.9))
                .padding(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            menuButton
                .padding(.horizontal, 10)
        }
    }
    
    private var menuButton: some View {
        Menu {
            Button(action: onEdit) {
                Label("Edit", systemImage: "pencil")
            }
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.gray)
                .frame(width: 40, height: 40)
                .contentShape(Rectangle())
        }
    }
}

#Preview("Book Button Layouts") {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        VStack(spacing: 20) {
            // Grid Layout
            BookButtonView(
                book: sampleBooks[0],
                onEdit: {},
                onDelete: {},
                isGridView: true
            )
            .frame(width: 180, height: 180)
            
            // List Layout
            BookButtonView(
                book: sampleBooks[1],
                onEdit: {},
                onDelete: {},
                isGridView: false
            )
            .frame(height: 80)
        }
        .padding()
    }
}