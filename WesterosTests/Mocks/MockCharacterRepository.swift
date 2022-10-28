//
//  MockHousesRepository.swift
//  WesterosTests
//
//  Created by Fitzgerald Afful on 27/10/2022.
//

import Foundation
@testable import Westeros

class MockCharacterRepository: CharacterRepositoryProtocol {
    func getCharacters(page: Int, completion: @escaping ([Character]?, Pagination?, String?) -> Void) {
        if let localData = JSONParser.readLocalFile(forName: "characters"),
           let characters = JSONParser.parse(jsonData: localData, as: [Character].self) {
            completion(characters, nil, nil)
        }
    }


    func getCharacter(url: String, completion: @escaping (Character?, String?) -> Void) {
        if let localData = JSONParser.readLocalFile(forName: "character"),
           let character = JSONParser.parse(jsonData: localData, as: Character.self) {
            completion(character, nil)
        }
    }
}
