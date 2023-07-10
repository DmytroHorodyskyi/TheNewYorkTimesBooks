//
//  BooksViewModel.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 05.07.2023.
//

import Foundation
import Alamofire

class BooksViewModel: ObservableObject {
    
    @Published var books: Books?
    private let tunnel = "https://"
    private let domainName = "api.nytimes.com"
    private let way = "/svc/books/v3///lists/current/"
    private let type = ".json"
    private let apiKey = "?api-key=5LB6Yz5cmT0Hl9JAPPKVoMYAA2j4bkP1"
    private var booksManager: BooksManager?
    static var shared = BooksViewModel()
    
    private func createURL(by category: Category) -> String {
        let category = category.list_name_encoded
        print(tunnel + domainName + way + category + type + apiKey)
        return tunnel + domainName + way + category + type + apiKey
    }
    
    private func loadFromTheStorage() {
        do {
            self.booksManager = try BooksManager()
        } catch {
            print("Failed to create BooksManager: \(error)")
        }
        if let bookObjects = booksManager?.getBooks() {
            let books = Books(
                num_results: bookObjects.numResults,
                results: Results(
                    list_name: bookObjects.results?.listName ?? "",
                    books: bookObjects.results?.books.map {
                        Book(rank: $0.rank,
                             publisher: $0.publisher,
                             description: $0.descriptionText,
                             title: $0.title,
                             author: $0.author,
                             book_image: $0.bookImage,
                             amazon_product_url: $0.amazonProductURL)
                    } ?? []
                )
            )
            self.books = books
        }
    }
    
    func fetchBooks(by category: Category) {
        let reachabilityManager = NetworkReachabilityManager()
        guard let isNetworkReachable = reachabilityManager?.isReachable, isNetworkReachable else {
            loadFromTheStorage()
            return
        }
        AF.request(createURL(by: category))
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        print(error)
                    }
                    return
                }
                do {
                    let books = try JSONDecoder().decode(Books.self, from: data)
                    self.books = books
                    DispatchQueue.global().async {
                        self.booksManager?.saveBooks(books: books)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
    }
}
