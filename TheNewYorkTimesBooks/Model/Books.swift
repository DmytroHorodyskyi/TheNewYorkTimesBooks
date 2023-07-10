//
//  Book.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 04.07.2023.
//

import Foundation

struct Books: Codable {
    let num_results: Int
    let results: Results
}

struct Results: Codable {
    let list_name: String
    let books: [Book]
}

struct Book: Codable {
    let rank: Int
    let publisher: String
    let description: String
    let title: String
    let author: String
    let book_image: String
    let amazon_product_url: String
}


