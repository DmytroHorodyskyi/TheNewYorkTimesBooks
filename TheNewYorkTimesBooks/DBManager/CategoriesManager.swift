//
//  CategoriesManager.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 09.07.2023.
//

import Foundation
import RealmSwift

class CategoriesManager {
    private let realm: Realm
    
    init() throws {
        realm = try Realm()
    }
    
    func saveCategories(categories: Categories) {
        let categoriesObject = CategoriesObject()
        categoriesObject.numResults = categories.num_results
        for category in categories.results {
            let categoryObject = CategoryObject()
            categoryObject.listName = category.list_name
            categoryObject.listNameEncoded = category.list_name_encoded
            categoryObject.oldestPublishedDate = category.oldest_published_date
            if realm.objects(CategoryObject.self).filter("listName == %@", categoryObject.listName).first != nil {
                continue
            }
            categoriesObject.results.append(categoryObject)
        }
        try? realm.write {
            realm.add(categoriesObject)
        }
    }
    
    func getCategories() -> [CategoryObject] {
        Array(realm.objects(CategoryObject.self))
    }
}
