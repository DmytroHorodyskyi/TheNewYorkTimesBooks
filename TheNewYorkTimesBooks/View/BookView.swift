//
//  BookView.swift
//  TheNewYorkTimesBooks
//
//  Created by Dmytro Horodyskyi on 05.07.2023.
//

import SwiftUI
import SafariServices

struct BookView: View {
    
    @State private var showDescription: Bool = false
    @State private var showBuyPage: Bool = false
    let rank: Int
    let imageURL: String
    let title: String
    let author: String
    let publisher: String
    let description: String
    let link: String
    
    var body: some View {
        HStack(spacing: 3) {
            AsyncImage(url: URL(string: imageURL)) { image in
                switch image {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.27)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 100, maxHeight: 100)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .center) {
                Text("(\(rank))" + title)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.vertical, 5)
                Text(author)
                Text(publisher)
                Spacer()
                HStack(alignment: .bottom, spacing: 3) {
                    Button {
                        showDescription.toggle()
                    } label: {
                        Text("Description")
                            .foregroundStyle(Color.black)
                            .padding(5)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .background(Color(#colorLiteral(red: 0.9825914502, green: 0.7682731748, blue: 0.4722165465, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    }
                    .sheet(isPresented: $showDescription) {
                        DescriptionBookView(title: title, description: description)
                    }
                    Button {
                        showBuyPage.toggle()
                    } label: {
                        Text("Buy")
                            .foregroundStyle(Color.black)
                            .padding(7)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .background(Color(#colorLiteral(red: 0.7173044086, green: 0.8371037841, blue: 0.9842229486, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    }
                    .sheet(isPresented: $showBuyPage) {
                        SafariView(url: URL(string: link)!)
                            .ignoresSafeArea()
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.bottom, 5)
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height * 0.2)
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(
            rank: 1,
            imageURL: "https://storage.googleapis.com/du-prd/books/images/9780316258777.jpg",
            title: "THE FIVE-STAR WEEKEND",
            author: "Elin Hilderbrand",
            publisher: "Little, Brown",
            description: "After a tragedy, a popular food blogger brings friends from distinct times in her life to spend a weekend in Nantucket.",
            link: "https://www.amazon.com/dp/0316258776?tag=NYTBSREV-20"
        )
    }
}
