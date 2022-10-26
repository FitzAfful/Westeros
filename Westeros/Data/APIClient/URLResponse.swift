//
//  URLResponse.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

extension HTTPURLResponse {

    public enum Page {
        case prev
        case next
        case last

        var rawValue: String {
            switch self {
            case .prev: return "prev"
            case .next: return "next"
            case .last: return "last"
            }
        }
    }

    public func getPage(_ page: Page) -> Int? {
        guard let link = self.allHeaderFields["Link"] as? String else { return nil }
        let components = link.components(separatedBy: ",")
        guard
            let pageLink = components.filter({ $0.contains(page.rawValue) }).first,
            let pageUrlString = pageLink.slice(from: "<", to: ">"),
            let url = URL(string: pageUrlString),
            let pageString = url.valueOf("page") else { return nil }
        return Int(pageString)
    }

    func isPaginated() -> Bool {
        return getPage(.last) != nil
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
