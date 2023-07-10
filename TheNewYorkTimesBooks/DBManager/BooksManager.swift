//
//  BooksManager.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 09.07.2023.
//

import Foundation
import RealmSwift

class BooksManager {
    private let realm: Realm
    
    init() throws {
        realm = try Realm()
    }
    
    func saveBooks(books: Books) {
        let booksObject = BooksObject()
        booksObject.numResults = books.num_results
        let resultsObject = ResultsObject()
        resultsObject.listName = books.results.list_name
        for book in books.results.books {
            let bookObject = BookObject()
            bookObject.rank = book.rank
            bookObject.publisher = book.publisher
            bookObject.descriptionText = book.description
            bookObject.title = book.title
            bookObject.author = book.author
            bookObject.bookImage = book.book_image
            bookObject.amazonProductURL = book.amazon_product_url
            if realm.objects(BookObject.self).filter("title == %@", bookObject.title).first != nil {
                continue
            }
            resultsObject.books.append(bookObject)
        }
        booksObject.results = resultsObject
        try? realm.write {
            realm.add(booksObject)
        }
    }
    
    func getBooks() -> BooksObject? {
        realm.objects(BooksObject.self).first
    }
}
