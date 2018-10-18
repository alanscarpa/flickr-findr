//
//  NetworkManager.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                let result = resource.parse(data)
                completion(.success(result!))
            } else {
                completion(.failure(NetworkError.noData))
                return
            }
        }.resume()
    }
}

struct NetworkManager {
    static func request(_ requestType: RequestType, completion: @escaping (Result<Data>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/rest"
        // NOTE:  per_page value is set to 26 because after setting nojsoncallback value to 1, flickrAPI returns 1 less photo for some reason.
        components.queryItems = [URLQueryItem(name: "api_key", value: flickrAPIKey),
                                 URLQueryItem(name: "format", value: "json"),
                                 URLQueryItem(name: "per_page", value: "26"),
                                 URLQueryItem(name: "page", value: "1"),
                                 URLQueryItem(name: "nojsoncallback", value: "1")
                                 ]
        switch requestType {
        case .search(let searchTerm):
            components.queryItems?.append(URLQueryItem(name: "tags", value: searchTerm))
            components.queryItems?.append(URLQueryItem(name: "method", value: "flickr.photos.search"))
        }
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
               completion(.success(data))
            } else {
                completion(.failure(NetworkError.noData))
                return
            }
        }.resume()
    }
}

enum RequestType {
    case search(String)
}
