//
//  CharacterDetailView.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import SwiftUI

struct CharacterView: View {
    @ObservedObject var viewModel: CharacterViewModel

    var body: some View {
        
        ZStack{
            GeometryReader { geometry in
                Image("houseBackground")
                    .scaledToFill()

                VStack {
                    if let character = viewModel.character {
                        if let name = character.name {
                            TitleRow(title: name)
                                .padding(.top, 32)
                        }

                        ScrollView (.vertical, showsIndicators: false) {
                            Group {

                                if !character.gender.isEmpty {
                                    DetailRow(key: "Gender", value: character.gender)
                                }

                                if !character.culture.isEmpty {
                                    DetailRow(key: "Culture", value: character.culture)
                                }

                                if !character.born.isEmpty {
                                    DetailRow(key: "Born", value: character.born)
                                }

                                if !character.died.isEmpty {
                                    DetailRow(key: "Died", value: character.died)
                                }

                                if !character.titles.filter({ $0 != "" }).isEmpty {
                                    DetailRow(key: "Titles", value: "• " + character.titles.joined(separator: "\n• "))
                                }

                                if !character.aliases.filter({ $0 != "" }).isEmpty {
                                    DetailRow(key: "Aliases", value: "• " + character.aliases.joined(separator: "\n• "))
                                }
                            }

                            Group {

                                if let father = viewModel.father {
                                    DetailRow(key: "Fther", value: father)
                                }

                                if let mother = viewModel.mother {
                                    DetailRow(key: "Mother", value: mother)
                                }

                                if let spouse = viewModel.spouse {
                                    DetailRow(key: "Spouse", value: spouse)
                                }

                                if !viewModel.allegiances.isEmpty {
                                    DetailRow(key: "Allegiances", value: "• " + viewModel.allegiances.joined(separator: "\n• "))
                                }
                            }

                            Group {
                                if !character.tvSeries.isEmpty {
                                    DetailRow(key: "TV Series", value: "• " + character.tvSeries.joined(separator: "\n• "))
                                }

                                if !viewModel.povBooks.isEmpty {
                                    DetailRow(key: "POV Books", value: "• " + viewModel.povBooks.joined(separator: "\n• "))
                                }

                                if !viewModel.books.isEmpty {
                                    DetailRow(key: "Books", value: "• " + viewModel.books.joined(separator: "\n• "))
                                }

                                if !viewModel.playedBy.isEmpty {
                                    DetailRow(key: "Played By", value: "• " + viewModel.playedBy.joined(separator: "\n• "))
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
