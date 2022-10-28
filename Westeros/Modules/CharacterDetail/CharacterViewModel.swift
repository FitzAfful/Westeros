//
//  HouseDetailViewModel.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Combine

class CharacterViewModel: ObservableObject {
    var characterRepo: CharacterRepositoryProtocol = CharacterRepository()
    var houseRepo: HouseRepositoryProtocol = HouseRepository()
    var bookRepo: BookRepositoryProtocol = BookRepository()

    @Published var character: Character?

    @Published var father: String?
    @Published var mother: String?
    @Published var spouse: String?
    @Published var allegiances: [String] = []
    @Published var playedBy: [String] = []
    @Published var books: [String] = []
    @Published var povBooks: [String] = []



    init(character: Character) {
        self.character = character
    }

    func onAppear() {
        guard let character = self.character else { return }

        if !character.father.isEmpty {
            self.getCharacterDetails(url: character.father) { character in
                self.father = character.name
            }
        }

        if !character.mother.isEmpty {
            self.getCharacterDetails(url: character.mother) { character in
                self.mother = character.name
            }
        }

        if !character.spouse.isEmpty {
            self.getCharacterDetails(url: character.spouse) { character in
                self.spouse = character.name
            }
        }

        for item in character.allegiances {
            self.getHouseDetails(url: item) { house in
                self.allegiances.append(house.name)
            }
        }

        for item in character.povBooks {
            self.getCharacterDetails(url: item) { book in
                self.povBooks.append(book.name)
            }
        }

        for item in character.books {
            self.getCharacterDetails(url: item) { book in
                self.books.append(book.name)
            }
        }
    }

    func getCharacterDetails(url: String, completion: @escaping (Character) -> Void) {
        characterRepo.getCharacter(url: url) { character, errorMessage in
            if let character, !character.name.isEmpty {
                completion(character)
            }
        }
    }

    func getHouseDetails(url: String, completion: @escaping (House) -> Void) {
        houseRepo.getHouse(url: url) { house, errorMessage in
            if let house, !house.name.isEmpty {
                completion(house)
            }
        }
    }

    func getBookDetails(url: String, completion: @escaping (Book) -> Void) {
        bookRepo.getBook(url: url) { book, errorMessage in
            if let book, !book.name.isEmpty {
                completion(book)
            }
        }
    }

}
