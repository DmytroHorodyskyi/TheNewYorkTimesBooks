//
//  BooksObject.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 09.07.2023.
//

import Foundation
import RealmSwift

class BookObject: Object {
    @Persisted var rank = 0
    @Persisted var publisher = ""
    @Persisted var descriptionText = ""
    @Persisted var title = ""
    @Persisted var author = ""
    @Persisted var bookImage = ""
    @Persisted var amazonProductURL = ""
}

class ResultsObject: Object {
    @Persisted var listName = ""
    @Persisted var books = List<BookObject>()
}

class BooksObject: Object {
    @Persisted var numResults = 0
    @Persisted var results: ResultsObject?
}
