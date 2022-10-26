//
//  Font+Extension.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import SwiftUI

extension Font {
    static func gameOfThrones(size: Double = 18) -> Font {
        return self.baseFontAction(name: "Game of Thrones", size: size)
    }

    static func baseFontAction(name: String, size: Double) -> Font {
        return Font.custom(name, size: CGFloat(size))
    }
}


extension Text {
    func defaultGOTFont(color: Color = .black, size: Double = 20) -> Text {
        self.font(.gameOfThrones(size: size))
            .foregroundColor(color)
    }
}
