//
//  DummyBooks.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import Foundation

let sampleBooks: [Book] = [
    Book(title: "Brave New World", author: "Aldous Huxley"),
    Book(title: "1984", author: "George Orwell"),
    Book(title: "Fahrenheit 451", author: "Ray Bradbury"),
    Book(title: "Animal Farm", author: "George Orwell"),
    Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald")
]

func getSampleBooks() -> [Book] {
    return sampleBooks
}
