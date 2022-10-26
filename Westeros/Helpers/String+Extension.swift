//
//  String+Extension.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

extension String {

    var isCharacter: Bool {
        guard self.contains("anapioficeandfire.com/api/characters") else { return false }
        guard URL (string: self) != nil else { return false }
        return true
    }

    var isHouse: Bool {
        guard self.contains("anapioficeandfire.com/api/houses") else { return false }
        guard URL (string: self) != nil else { return false }
        return true
    }
}
