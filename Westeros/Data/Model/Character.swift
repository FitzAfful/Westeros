//
//  Character.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

struct Character: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var gender: String
    var culture: String
    var born: String
    var url: String
    var titles: [String]
    var aliases: [String]
    var father: String
    var mother: String
    var spouse: String
    var allegiances: [String]
    var playedBy: [String]


    private enum CodingKeys : String, CodingKey {
        case name, gender, culture, born, url, titles, aliases, father, mother, spouse, allegiances, playedBy
    }
}
