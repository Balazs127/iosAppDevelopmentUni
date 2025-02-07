//
//  ModernButton.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct ModernButton: View {
    var title: String
    var iconName: String? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if let iconName = iconName {
                    Image(systemName: iconName)
                }
                Text(title)
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
        }
    }
}
