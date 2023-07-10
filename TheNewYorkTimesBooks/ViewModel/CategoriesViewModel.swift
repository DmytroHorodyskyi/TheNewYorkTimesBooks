//
//  CategoriesViewModel.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 04.07.2023.
//

import Foundation
import Alamofire

class CategoriesViewModel: ObservableObject {
    
    @Published var categories: Categories?
    private let tunnel = "https://"
    private let domainName = "api.nytimes.com"
    private let way = "/svc/books/v3///lists/names"
    private let type = ".json"
    private let apiKey = "?api-key=5LB6Yz5cmT0Hl9JAPPKVoMYAA2j4bkP1"
    private var categoriesManager: CategoriesManager?
    static var shared = CategoriesViewModel()
    
    private func createURL() -> String {
        tunnel + domainName + way + type + apiKey
    }
    
    private func loadFromTheStorage() {
        do {
            self.categoriesManager = try CategoriesManager()
        } catch {
            print("Failed to create CategoriesManager: \(error)")
        }
        if let categoryObjects = categoriesManager?.getCategories() {
            let categories = Categories(
                num_results: categoryObjects.count,
                results: categoryObjects.map {
                    Category(list_name: $0.listName,
                             list_name_encoded: $0.listNameEncoded,
                             oldest_published_date: $0.oldestPublishedDate) })
            self.categories = categories
        }
    }
    
    func fetchCategories() {
        let reachabilityManager = NetworkReachabilityManager()
        guard let isNetworkReachable = reachabilityManager?.isReachable, isNetworkReachable else {
            loadFromTheStorage()
            return
        }
        AF.request(createURL())
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        print(error)
                    }
                    return
                }
                do {
                    let categories = try JSONDecoder().decode(Categories.self, from: data)
                    self.categories = categories
                    DispatchQueue.global().async {
                        self.categoriesManager?.saveCategories(categories: categories)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
    }
}
