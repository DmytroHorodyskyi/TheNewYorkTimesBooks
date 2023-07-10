//
//  ContentView.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 04.07.2023.
//

import SwiftUI

struct CategoriesContentView: View {
    
    @StateObject private var categoriesViewModel = CategoriesViewModel.shared
    var body: some View {
        NavigationView {
            if let categories = categoriesViewModel.categories {
                List {
                    ForEach(categories.results, id: \.list_name) { category in
                        NavigationLink(destination: BooksContentView(category)) {
                            CategoryView(category)
                        }
                    }
                }
                .navigationTitle("Categories (\(categories.num_results))")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .brown))
                    .scaleEffect(2)
                    .navigationTitle("Categories")
                    .navigationBarTitleDisplayMode(.large)
            }
        }
        .onAppear {
            categoriesViewModel.fetchCategories()
        }
    }
}


struct CategoriesContentView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesContentView()
    }
}
