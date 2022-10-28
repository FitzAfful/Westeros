//
//  HouseDetailView.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import SwiftUI

struct BookView: View {
    @ObservedObject var viewModel: BookViewModel

    var body: some View {

        ZStack{
            GeometryReader { geometry in
                Image("houseBackground")
                    .scaledToFill()

                VStack {
                    if let book = viewModel.book {
                        if let name = book.name {
                            TitleRow(title: name)
                                .padding(.top, 32)
                        }

                        ScrollView (.vertical, showsIndicators: false) {
                            Group {

                                if !book.isbn.isEmpty {
                                    DetailRow(key: "ISBN", value: book.isbn)
                                }

                                DetailRow(key: "Number of pages", value: "\(book.numberOfPages)")

                                if !book.authors.isEmpty {
                                    DetailRow(key: "Authors", value: "• " + book.authors.joined(separator: "\n• "))
                                }
                            }

                            Group {

                                if !book.country.isEmpty {
                                    DetailRow(key: "Country", value: book.country)
                                }

                                if !book.mediaType.isEmpty {
                                    DetailRow(key: "Media Type", value: book.mediaType)
                                }

                                if !book.publisher.isEmpty {
                                    DetailRow(key: "Publisher", value: book.publisher)
                                }

                                if !book.released.isEmpty {
                                    DetailRow(key: "Released", value: book.released)
                                }
                            }

                            Group {
                                if !viewModel.characters.isEmpty {
                                    DetailRow(key: "Characters", value: "• " + viewModel.characters.joined(separator: "\n• "))
                                }

                                if !viewModel.povCharacters.isEmpty {
                                    DetailRow(key: "POV Characters", value: "• " + viewModel.povCharacters.joined(separator: "\n• "))
                                }
                            }

                        }
                        .frame(height: geometry.size.height)
                        .padding()
                    }
                }
                .padding(.top, 55)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
