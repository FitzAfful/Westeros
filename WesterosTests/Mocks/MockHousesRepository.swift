//
//  MockHousesRepository.swift
//  WesterosTests
//
//  Created by Fitzgerald Afful on 27/10/2022.
//

import Foundation
@testable import Westeros

class MockHouseRepository: HouseRepositoryProtocol {
    func loadHouses(page: Int, completion: @escaping ([House]?, Pagination?, String?) -> Void) {
        if let localData = JSONParser.readLocalFile(forName: "houses"),
           let houses = JSONParser.parse(jsonData: localData, as: [House].self) {
            completion(houses, nil, nil)
        }
    }

    func getHouse(url: String, completion: @escaping (House?, String?) -> Void) {
        if let localData = JSONParser.readLocalFile(forName: "house"),
           let house = JSONParser.parse(jsonData: localData, as: House.self) {
            completion(house, nil)
        }
    }
}
