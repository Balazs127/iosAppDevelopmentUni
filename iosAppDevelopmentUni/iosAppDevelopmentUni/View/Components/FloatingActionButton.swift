//
//  FloatingActionButton.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 16/02/2025.
//

import SwiftUI

struct FloatingActionButton: View {
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(
                            Circle()
                                .fill(Color.blue)
                                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        )
                }
                .padding(.trailing, 20)
                .padding(.bottom, 15)
            }
        }
    }
}

#Preview {
    FloatingActionButton(action: { print("FAB pressed.") })
    .padding()
}
