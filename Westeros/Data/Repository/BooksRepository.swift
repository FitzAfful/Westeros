//
//  BooksRepository.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation
import Combine

protocol BookRepositoryProtocol {
    func loadBooks(page: Int, completion: @escaping([Book]?, Pagination?, String?) -> Void)
    func getBook(url: String, completion: @escaping(Book?, String?) -> Void)
}

class BookRepository: BookRepositoryProtocol {
    private let pageSize = 30

    func loadBooks(page: Int = 0, completion: @escaping([Book]?, Pagination?, String?) -> Void) {
        URLSession.loadRequest(endpoint: .getBooks(page, pageSize), as: [Book].self) { result in
            switch result {
            case .success(let response):
                completion(response.data, response.pagination, nil)
            case .failure(let error):
                // get error message
                completion(nil, nil, error.localizedDescription)
            }
        }
    }

    func getBook(url: String, completion: @escaping(Book?, String?) -> Void) {
        guard let url = URL (string: url) else { return }
        let id = url.lastPathComponent
        URLSession.loadRequest(endpoint: .getBook(id), as: Book.self) { result in
            switch result {
            case .success(let response):
                completion(response.data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
