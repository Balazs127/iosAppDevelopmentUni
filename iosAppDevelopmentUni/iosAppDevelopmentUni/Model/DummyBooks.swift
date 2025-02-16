//
//  DummyBooks.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import Foundation

let sampleBooks: [Book] = [
    Book(
        title: "Brave New World",
        author: "Aldous Huxley",
        bookDescription: "A dystopian novel about a futuristic World State and its citizens who are environmentally engineered into a intelligence-based social hierarchy.",
        rating: 4.5,
        genre: "Science Fiction",
        totalPages: 311,
        pagesRead: 0
    ),
    Book(
        title: "1984",
        author: "George Orwell",
        bookDescription: "A dystopian social science fiction novel following Winston Smith in a totalitarian state that maintains power through surveillance, manipulation, and control.",
        rating: 4.8,
        genre: "Dystopian Fiction",
        totalPages: 328,
        pagesRead: 0
    ),
    Book(
        title: "Fahrenheit 451",
        author: "Ray Bradbury",
        bookDescription: "A dystopian novel about a future American society where books are outlawed and 'firemen' burn any that are found.",
        rating: 4.3,
        genre: "Dystopian Fiction",
        totalPages: 256,
        pagesRead: 0
    ),
    Book(
        title: "Animal Farm",
        author: "George Orwell",
        bookDescription: "An allegorical novella reflecting events leading up to the Russian Revolution and the Stalinist era of the Soviet Union.",
        rating: 4.6,
        genre: "Political Satire",
        totalPages: 141,
        pagesRead: 0
    ),
    Book(
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        bookDescription: "A story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan, set against the backdrop of the Roaring Twenties.",
        rating: 4.4,
        genre: "Literary Fiction",
        totalPages: 180,
        pagesRead: 0
    )
]

func getSampleBooks() -> [Book] {
    return sampleBooks
}
