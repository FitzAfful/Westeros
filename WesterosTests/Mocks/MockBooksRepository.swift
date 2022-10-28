//
//  Mock BooksRepository.swift
//  WesterosTests
//
//  Created by Fitzgerald Afful on 27/10/2022.
//

import Foundation
@testable import Westeros

class MockBookRepository: BookRepositoryProtocol {
    func loadBooks(page: Int, completion: @escaping ([Book]?, Pagination?, String?) -> Void) {
        if let localData = JSONParser.readLocalFile(forName: "books"),
           let books = JSONParser.parse(jsonData: localData, as: [Book].self) {
            completion(books, nil, nil)
        }
    }

    func getBook(url: String, completion: @escaping (Book?, String?) -> Void) {
        if let localData = JSONParser.readLocalFile(forName: "book"),
           let book = JSONParser.parse(jsonData: localData, as: Book.self) {
            completion(book, nil)
        }
    }
}
