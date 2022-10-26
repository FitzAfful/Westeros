//
//  House.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

struct House: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var region: String
    var words: String
    var coatOfArms: String
    var titles: [String]
    var url: String
    var currentLord: String
    var seats: [String]
    var heir: String
    var overlord: String
    var founded: String
    var founder: String
    var diedOut: String
    var ancestralWeapons: [String]
    var cadetBranches: [String]
    var swornMembers: [String]

    private enum CodingKeys : String, CodingKey {
        case name, region, words, coatOfArms, titles, url, currentLord, seats,
             heir, overlord, founded, founder, diedOut, ancestralWeapons, cadetBranches, swornMembers
    }

    func getImage() -> String {
        var regionImages: [String: String] =
            [
                "The Reach": "reach",
                "The Riverlands": "riverlands",
                "The Westerlands": "westerlands",
                "The Crownlands": "crownlands",
                "Dorne": "dorne",
                "The Neck": "neck",
                "Iron Islands": "iron islands",
                "The North": "north",
                "The Vale": "vale",
                "Beyond The Wall": "beyond"
            ]
        return regionImages[self.region] ?? "crownlands"
    }
}
