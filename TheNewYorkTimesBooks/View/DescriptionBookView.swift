//
//  DescriptionBookView.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 05.07.2023.
//

import SwiftUI

struct DescriptionBookView: View {
    
    @Environment(\.dismiss) var dismiss
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Back")
                }
                Spacer()
            }
            .padding()
            Text(title)
                .font(.title)
                .bold()
            List {
                Text(description)
                    .font(.system(size: 21))
                    .padding()
            }
            Spacer()
        }
    }
}


struct DescriptionBookView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionBookView(title: "Too Late", description: "After a tragedy, a popular food blogger brings friends from distinct times in her life to spend a weekend in Nantucket.")
    }
}
