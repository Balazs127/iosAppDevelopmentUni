//
//  SearchBar.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text, prompt: Text("Search books...")
                    .foregroundColor(Color.white.opacity(0.7)))
            .padding(10)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.vertical, 5)
    }
}

#Preview {
    @State @Previewable var searchText = "" // ✅ Provide a binding for preview

    return SearchBar(text: $searchText)
        .padding()
        .background(Color.black)
}
