//
//  HouseDetailViewModel.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Combine

class BookViewModel: ObservableObject {
    var characterRepo: CharacterRepositoryProtocol = CharacterRepository()
    var houseRepo: HouseRepositoryProtocol = HouseRepository()

    @Published var book: Book?
    @Published var characters: [String] = []
    @Published var povCharacters: [String] = []

    init(book: Book) {
        self.book = book
    }

    func onAppear() {
        guard let book = self.book else { return }

        for character in book.characters {
            self.getCharacterDetails(url: character) { newCharacter in
                self.characters.append(newCharacter.name)
            }
        }

        for character in book.povCharacters {
            self.getCharacterDetails(url: character) { newCharacter in
                self.povCharacters.append(newCharacter.name)
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

}
