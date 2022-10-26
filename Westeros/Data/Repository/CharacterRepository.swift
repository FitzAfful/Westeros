//
//  CharacterRepository.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

class CharacterRepository {

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
