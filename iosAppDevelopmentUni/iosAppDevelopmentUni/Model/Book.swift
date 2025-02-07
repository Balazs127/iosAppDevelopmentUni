//
//  Book.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
}
