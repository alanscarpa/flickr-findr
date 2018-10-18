//
//  NetworkManager.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

struct NetworkManager {
    static func request(_ requestType: RequestType, completion: @escaping (Result<Data>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/rest"
        components.queryItems = [URLQueryItem(name: "api_key", value: flickrAPIKey),
                                 URLQueryItem(name: "format", value: "json"),
                                 URLQueryItem(name: "per_page", value: "25"),
                                 URLQueryItem(name: "page", value: "1"),
                                 ]
        switch requestType {
        case .search(let searchTerm):
            components.queryItems?.append(URLQueryItem(name: "text", value: searchTerm))
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
                let photos = try? JSONDecoder().decode([Photo].self, from: data)
                print(photos)
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