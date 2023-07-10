//
//  BooksContentView.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 05.07.2023.
//

import SwiftUI

struct BooksContentView: View {
    
    @StateObject private var booksViewModel = BooksViewModel.shared
    let category: Category
    
    init(_ category: Category) {
        self.category = category
    }
    
    var body: some View {
        NavigationView {
            if let books = booksViewModel.books {
                List {
                    ForEach(books.results.books, id: \.rank) { book in
                        BookView(rank: book.rank, imageURL: book.book_image, title: book.title, author: book.author, publisher: book.publisher, description: book.description, link: book.amazon_product_url)
                    }
                }
                .navigationTitle(category.list_name + " (\(books.num_results))")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .brown))
                    .scaleEffect(2)
                    .navigationTitle("Books")
                    .navigationBarTitleDisplayMode(.large)
            }
        }
        .onAppear() {
            booksViewModel.fetchBooks(by: category)
        }
    }
}

struct BooksContentView_Previews: PreviewProvider {
    static var previews: some View {
        BooksContentView(Category(list_name: "Combined Print and E-Book Fiction", list_name_encoded: "hardcover-fiction", oldest_published_date: "2011-02-13"))
    }
}
