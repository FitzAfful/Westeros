//
//  HousesRepository.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation
import Combine

protocol HouseRepositoryProtocol {
    func loadHouses(page: Int, completion: @escaping([House]?, Pagination?, String?) -> Void)
    func getHouse(url: String, completion: @escaping(House?, String?) -> Void)
}

class HouseRepository: HouseRepositoryProtocol {
    private let pageSize = 30

    func loadHouses(page: Int = 0, completion: @escaping([House]?, Pagination?, String?) -> Void) {
        URLSession.loadRequest(endpoint: .getHouses(page, pageSize), as: [House].self) { result in
            switch result {
            case .success(let response):
                completion(response.data, response.pagination, nil)
            case .failure(let error):
                // get error message
                completion(nil, nil, error.localizedDescription)
            }
        }
    }

    func getHouse(url: String, completion: @escaping(House?, String?) -> Void) {
        guard let url = URL (string: url) else { return }
        let id = url.lastPathComponent
        URLSession.loadRequest(endpoint: .getHouse(id), as: House.self) { result in
            switch result {
            case .success(let response):
                completion(response.data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
