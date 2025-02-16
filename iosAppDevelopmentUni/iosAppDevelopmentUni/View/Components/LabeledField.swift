//
//  EditBookView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 16/02/2025.
//

import SwiftUI

struct LabeledField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var axis: Axis? = nil
    var keyboardType: UIKeyboardType = .default
    @FocusState.Binding var focus: Field?
    let field: Field
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(label)\(isRequired ? "*" : "")")
                .foregroundColor(.secondary)
            TextField(placeholder, text: $text, axis: axis ?? .horizontal)
                .focused($focus, equals: field)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focus == field ? Color.blue : Color.gray.opacity(0.3), 
                                       lineWidth: focus == field ? 2 : 1)
                        )
                )
                .animation(.easeInOut(duration: 0.2), value: focus == field)
                .keyboardType(keyboardType)
        }
        .padding(.vertical, 4)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    @Previewable @State var previewText = ""
    @FocusState var previewFocus: Field?
    
    return Form {
        LabeledField(
            label: "Title",
            placeholder: "Enter a title",
            text: .constant(""),
            isRequired: true,
            focus: $previewFocus,
            field: .title
        )
    }
    .frame(height: 150)
}

