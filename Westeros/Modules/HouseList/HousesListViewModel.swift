//
//  HousesListViewModel.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

class HousesListViewModel: ObservableObject {
    private var repo = HouseRepository()

    @Published var searchText: String = "" {
        didSet {
            filterHouses()
        }
    }
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var filteredHouses: [House] = []
    @Published private(set) var houses: [House] = [] {
        didSet { filterHouses() }
    }
    @Published private(set) var currentPage: Int = 0
    @Published private(set) var hasNextPage = false
    @Published private(set) var errorMessage: String? = nil

    func loadHouses() {
        repo.loadHouses(page: currentPage + 1) { [weak self] newHouses, pagination, errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                self.isLoading = false
                self.currentPage = self.currentPage + 1

                if let newHouses {
                    self.houses.append(contentsOf: newHouses)
                    print(self.houses)
                }

                if let pagination, let lastPage = pagination.last {
                    self.hasNextPage = self.currentPage < lastPage
                }

                if let errorMessage {
                    self.errorMessage = errorMessage
                }
            }
        }
    }

    func loadMore(currentHouse: House) {
        let thresholdIndex = self.houses.index(self.houses.endIndex, offsetBy: -7)
        if let currentIndex = self.houses.firstIndex(of: currentHouse) {
            if currentIndex >= thresholdIndex && self.hasNextPage {
                loadHouses()
            }
        }
    }

    func clearError() {
        errorMessage = nil
    }

    func filterHouses() {
        filteredHouses = houses
            .filter {
                searchText.isEmpty ||
                $0.name.lowercased().contains(searchText.lowercased()) }
            .sorted { $0.name.lowercased() < $1.name.lowercased() }
    }
}
