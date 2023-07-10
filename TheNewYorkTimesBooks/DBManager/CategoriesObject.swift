//
//  CategoriesObject.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 09.07.2023.
//

import Foundation
import RealmSwift

class CategoriesObject: Object {
    @Persisted var numResults = 0
    @Persisted var results = List<CategoryObject>()
}

class CategoryObject: Object {
    @Persisted var listName = ""
    @Persisted var listNameEncoded = ""
    @Persisted var oldestPublishedDate = ""
}
