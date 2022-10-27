//
//  JSONParser.swift
//  WesterosTests
//
//  Created by Fitzgerald Afful on 27/10/2022.
//

import Foundation

class JSONParser {
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }

        return nil
    }

    static func parse<T:Decodable>(jsonData: Data, as type: T.Type = T.self) -> T? {
        do {
            return try JSONDecoder().decode(type, from: jsonData)
        } catch {
            print("decode error")
        }
        return nil
    }
}
