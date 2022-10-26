//
//  HousesList.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation
import SwiftUI
import Combine

struct HousesListView: View {
    @ObservedObject var viewModel = HousesListViewModel()
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
                        Section {
                            SearchView(searchText: $viewModel.searchText)
                                .frame(maxHeight: 50)
                        }

                        ForEach(viewModel.filteredHouses) { house in
                            NavigationLink {
                                HouseDetailView(viewModel: HouseViewModel(house: house))
                            } label: {
                                HouseRow(house: house)
                                    .onAppear {
                                        viewModel.loadMore(currentHouse: house)
                                    }
                            }
                        }
                    }
                    .padding(.top, 60)
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
                viewModel.loadHouses()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HouseRow: View {
    var house: House

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(house.name)
                .lineLimit(1)
                .font(.title3)
            Spacer()
                .frame(height: 2)

            Text(house.region)
                .lineLimit(1)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}
