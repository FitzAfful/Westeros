//
//  CharacterRepository.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacters(page: Int, completion: @escaping([Character]?, Pagination?, String?) -> Void)
    func getCharacter(url: String, completion: @escaping(Character?, String?) -> Void)
}

class CharacterRepository: CharacterRepositoryProtocol {
    private let pageSize = 30

    func getCharacters(page: Int, completion: @escaping ([Character]?, Pagination?, String?) -> Void) {
        URLSession.loadRequest(endpoint: .getCharacters(page, pageSize), as: [Character].self) { result in
            switch result {
            case .success(let response):
                completion(response.data, response.pagination, nil)
            case .failure(let error):
                // get error message
                completion(nil, nil, error.localizedDescription)
            }
        }
    }


    func getCharacter(url: String, completion: @escaping(Character?, String?) -> Void) {
        guard let url = URL (string: url) else { return }
        let id = url.lastPathComponent
        URLSession.loadRequest(endpoint: .getCharacter(id), as: Character.self) { result in
            switch result {
            case .success(let response):
                completion(response.data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }

}
