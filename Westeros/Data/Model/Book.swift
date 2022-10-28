//
//  House.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

struct Book: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var isbn: String
    var authors: [String]
    var numberOfPages: Int
    var mediaType: String
    var released: String
    var url: String
    var publisher: String
    var characters: [String]
    var country: String
    var povCharacters: [String]

    private enum CodingKeys : String, CodingKey {
        case name, isbn, authors, numberOfPages, mediaType, released, url, publisher, characters, country, povCharacters
    }

}

extension Book {
    static func random() -> Book {
        let localData = JSONParser.readLocalFile(forName: "book")!
        return JSONParser.parse(jsonData: localData, as: Book.self)!
    }
}
