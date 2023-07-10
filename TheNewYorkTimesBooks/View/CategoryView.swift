//
//  CatetgoryView.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 05.07.2023.
//

import SwiftUI

struct CategoryView: View {
    
    let category: Category
    
    init(_ category: Category) {
        self.category = category
    }
    
    var body: some View {
        HStack {
            Text(category.list_name)
                .fontWeight(.semibold)
            Spacer()
            Text("(\(category.oldest_published_date))")
                .font(.system(size: 13))
        }
    }
}

struct CatetgoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(Category(list_name: "Combined Print and E-Book Fiction", list_name_encoded: "hardcover-fiction", oldest_published_date: "2011-02-13"))
    }
}
