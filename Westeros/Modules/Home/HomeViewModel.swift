//
//  HomeViewModel.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    var houseRepo: HouseRepositoryProtocol = HouseRepository()
    var bookRepo: BookRepositoryProtocol = BookRepository()
    var characterRepo: CharacterRepositoryProtocol = CharacterRepository()

    @Published var searchText: String = "" {
        didSet {
            switch currentCategory {
            case 1:
                filterBooks()
            case 2:
                filterCharacters()
            default:
                filterHouses()
            }
        }
    }
    @Published var currentCategory: Int = 0 {
        didSet {
            searchText = ""
        }
    }

    @Published private(set) var isLoading: Bool = true
    @Published var filteredHouses: [House] = []
    @Published var filteredBooks: [Book] = []
    @Published var filteredCharacters: [Character] = []

    @Published var houses: [House] = [] {
        didSet { filterHouses() }
    }
    @Published var books: [Book] = [] {
        didSet { filterBooks() }
    }
    @Published var characters: [Character] = [] {
        didSet { filterCharacters() }
    }

    @Published private(set) var currentBookPage: Int = 0
    @Published private(set) var currentCharacterPage: Int = 0
    @Published private(set) var currentHousePage: Int = 0

    @Published private(set) var hasCharactersNextPage = false
    @Published private(set) var hasBooksNextPage = false
    @Published private(set) var hasHousesNextPage = false

    @Published private(set) var errorMessage: String? = nil

    func loadData() {
        loadHouses()
        loadBooks()
        loadCharacters()
    }

    func loadHouses() {
        houseRepo.loadHouses(page: currentHousePage + 1) { [weak self] newHouses, pagination, errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                self.isLoading = false
                self.currentHousePage = self.currentHousePage + 1

                if let newHouses {
                    self.houses.append(contentsOf: newHouses)
                    print("House Count: \(newHouses.count)")
                    print("Houses Count: \(self.houses.count)")
                }

                if let pagination, let lastPage = pagination.last {
                    self.hasHousesNextPage = self.currentHousePage < lastPage
                }

                if let errorMessage {
                    self.errorMessage = errorMessage
                }
            }
        }
    }

    func loadBooks() {
        bookRepo.loadBooks(page: currentBookPage + 1) { [weak self] newBooks, pagination, errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                self.isLoading = false
                self.currentBookPage = self.currentBookPage + 1

                if let newBooks {
                    self.books.append(contentsOf: newBooks)
                }

                if let pagination, let lastPage = pagination.last {
                    self.hasBooksNextPage = self.currentBookPage < lastPage
                }

                if let errorMessage {
                    self.errorMessage = errorMessage
                }
            }
        }
    }

    func loadCharacters() {
        characterRepo.getCharacters(page: currentCharacterPage + 1) { [weak self] newCharacters, pagination, errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                self.isLoading = false
                self.currentCharacterPage = self.currentCharacterPage + 1

                if let newCharacters {
                    self.characters.append(contentsOf: newCharacters.filter({ $0.name != "" }))
                }

                if let pagination, let lastPage = pagination.last {
                    self.hasCharactersNextPage = self.currentCharacterPage < lastPage
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
            if currentIndex >= thresholdIndex && self.hasCharactersNextPage {
                loadHouses()
            }
        }
    }

    func loadMoreCharacters(currentCharacter: Character) {
        let thresholdIndex = self.characters.index(self.characters.endIndex, offsetBy: -7)
        if let currentIndex = self.characters.firstIndex(of: currentCharacter) {
            if currentIndex >= thresholdIndex && self.hasCharactersNextPage {
                loadCharacters()
            }
        }
    }

    func loadMoreBooks(currentBook: Book) {
        let thresholdIndex = self.books.index(self.books.endIndex, offsetBy: -7)
        if let currentIndex = self.books.firstIndex(of: currentBook) {
            if currentIndex >= thresholdIndex && self.hasBooksNextPage {
                loadBooks()
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

    func filterBooks() {
        filteredBooks = books
            .filter {
                searchText.isEmpty ||
                $0.name.lowercased().contains(searchText.lowercased()) }
            .sorted { $0.name.lowercased() < $1.name.lowercased() }
    }

    func filterCharacters() {
        filteredCharacters = characters
            .filter {
                searchText.isEmpty ||
                $0.name.lowercased().contains(searchText.lowercased()) }
            .sorted { $0.name.lowercased() < $1.name.lowercased() }
    }
}
