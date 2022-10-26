//
//  Endpoints.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation
import Combine

enum Endpoint {
    case getHouses(Int, Int)
    case getHouse(String)
    case getCharacter(String)

    var url: URL {
        switch self {
        case .getHouse(let id):
            return .makeForEndpoint("houses/\(id)")
        case .getHouses(let page, let pageSize):
            return .makeForEndpoint("houses?page=\(page)&pageSize=\(pageSize)")
        case .getCharacter(let id):
            return .makeForEndpoint("characters\(id)")
        }
    }

    var request: URLRequest {
        return URLRequest(url: url)
    }
}

extension URL {
    /// construct endpoint url using base url and endpoint string
    static func makeForEndpoint(_ endpoint: String) -> URL {
        return URL(string: "https://anapioficeandfire.com/api/\(endpoint)")!
    }

    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}

extension URLSession {
    static func loadRequest<T:Decodable>(endpoint: Endpoint, as type: T.Type = T.self, completionHandler: @escaping (Result<APIResponse<T>, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: endpoint.url) { data, response, error in
            do {
                if let data = data {
                    let json = try JSONDecoder().decode(type, from: data)
                    var apiResponse = APIResponse(data: json)

                    // add pagination details if exists
                    if let response = response as? HTTPURLResponse, response.isPaginated() {
                        let pagination = Pagination(next: response.getPage(.next), prev: response.getPage(.prev), last: response.getPage(.last))
                        apiResponse.pagination = pagination
                    }

                    completionHandler(Result.success(apiResponse))
                } else if let error = error {
                    completionHandler(Result.failure(error))
                }
            } catch {
                completionHandler(Result.failure(error))
            }
        }
        task.resume()
    }
}


