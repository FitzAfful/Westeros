//
//  HouseDetailViewModel.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Combine

class HouseViewModel: ObservableObject {
    let characterRepo = CharacterRepository()
    let houseRepo = HouseRepository()

    private var house: House?

    @Published var name: String?
    @Published var region: String?
    @Published var words: String?
    @Published var coatOfArms: String?
    @Published var titles: [String] = []
    @Published var url: String?
    @Published var currentLord: String?
    @Published var seats: [String] = []
    @Published var heir: String?
    @Published var overlord: String?
    @Published var founded: String?
    @Published var founder: String?
    @Published var diedOut: String?
    @Published var ancestralWeapons: [String] = []
    @Published var cadetBranches: [String] = []
    @Published var swornMembers: [String] = []

    init(house: House) {
        self.house = house

        self.name = house.name
        self.region = house.region
        self.words = house.words
        self.coatOfArms = house.coatOfArms
        self.titles = house.titles.filter({ $0 != "" })
        self.url = house.url


        self.getCharacterDetails(url: house.currentLord) { character in
            self.currentLord = character.name
        }

        self.seats = house.seats.filter({ $0 != "" })

        self.getCharacterDetails(url: house.heir) { character in
            self.heir = character.name
        }

        self.getCharacterDetails(url: house.overlord) { character in
            self.overlord = character.name
        }

        self.getHouseDetails(url: house.overlord) { house in
            self.overlord = house.name
        }

        self.overlord = house.overlord
        self.founded = house.founded
        self.founder = house.founder
        self.diedOut = house.diedOut
        self.ancestralWeapons = house.ancestralWeapons.filter({ $0 != "" })

        for cadetBranch in house.cadetBranches {
            self.getHouseDetails(url: cadetBranch) { character in
                self.cadetBranches.append(character.name)
            }
        }

        for member in house.swornMembers {
            self.getCharacterDetails(url: member) { character in
                self.swornMembers.append(character.name)
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

}
