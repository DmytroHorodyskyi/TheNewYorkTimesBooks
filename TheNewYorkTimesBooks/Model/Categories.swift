//
//  Category.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 04.07.2023.
//

import Foundation

struct Categories: Codable {
    let num_results: Int
    let results: [Category]
}

struct Category: Codable {
    let list_name: String
    let list_name_encoded: String
    let oldest_published_date: String
}




