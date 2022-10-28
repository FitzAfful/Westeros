//
//  HousesList.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation
import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State var selectedHouse: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.isLoading {
                    Spacer()
                    ActivityIndicator()
                    Spacer()
                } else {
                    List {
                        Picker("What is your favorite color?", selection: $viewModel.currentCategory) {
                            Text("Houses").tag(0)
                            Text("Books").tag(1)
                            Text("Characters").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .padding(8)
                        .listRowInsets(EdgeInsets())
                        .frame(maxWidth: .infinity, minHeight: 60)

                        SearchView(searchText: $viewModel.searchText)
                            .frame(maxHeight: 50)
                            .padding(8)
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: .infinity, minHeight: 60)

                        if viewModel.currentCategory == 0 {
                            ForEach(viewModel.filteredHouses) { house in
                                NavigationLink {
                                    HouseDetailView(viewModel: HouseViewModel(house: house))
                                } label: {
                                    ItemRow(title: house.name, subTitle: house.region, image: house.getImage())
                                        .onAppear {
                                            viewModel.loadMore(currentHouse: house)
                                        }
                                }
                            }
                        } else if viewModel.currentCategory == 1 {
                            ForEach(viewModel.filteredBooks) { book in
                                NavigationLink {
                                    BookView(viewModel: BookViewModel(book: book))
                                } label: {
                                    ItemRow(title: book.name, subTitle: "\(book.numberOfPages) pages")
                                        .onAppear {
                                            viewModel.loadMoreBooks(currentBook: book)
                                        }
                                }
                            }
                        } else {
                            ForEach(viewModel.filteredCharacters) { character in
                                NavigationLink {
                                    CharacterView(viewModel: CharacterViewModel(character: character))
                                } label: {
                                    ItemRow(title: character.name, subTitle: character.aliases.joined(separator: ", "))
                                        .onAppear {
                                            viewModel.loadMoreCharacters(currentCharacter: character)
                                        }
                                }
                            }
                        }
                    }
                    .padding(.top, 64)
                }

            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Westeros")
                            .defaultGOTFont(size: 28)
                    }
                }
            }
            .onAppear {
                viewModel.loadData()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ItemRow: View {
    var title: String
    var subTitle: String?
    var image: String?

    var body: some View {
        HStack {

            if let image {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
            }

            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(1)
                    .font(.subheadline)

                if let subTitle {
                    Spacer()
                        .frame(height: 2)
                    
                    Text(subTitle)
                        .lineLimit(1)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .frame(alignment: .center)
        }
    }
}
