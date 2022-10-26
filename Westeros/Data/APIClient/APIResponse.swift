//
//  APIResponse.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation

struct APIResponse<T: Decodable> {
    var data: T
    var pagination: Pagination?
}

struct Pagination: Codable {
    var next: Int?
    var prev: Int?
    var last: Int?
}
