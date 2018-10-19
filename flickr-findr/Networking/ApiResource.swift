//
//  ApiResource.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

protocol ApiResource {
    associatedtype Model: Decodable
    var parameters: [URLQueryItem] { get }
}

extension ApiResource {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/rest"
        components.queryItems = [URLQueryItem(name: "api_key", value: flickrAPIKey),
                                 URLQueryItem(name: "format", value: "json"),
                                 URLQueryItem(name: "per_page", value: "25"),
                                 URLQueryItem(name: "page", value: "1"),
                                 URLQueryItem(name: "nojsoncallback", value: "1")]
        components.queryItems?.append(contentsOf: parameters)
        return components.url!
    }
    
    func makeModel(data: Data) -> Model? {
        do {
            return try JSONDecoder().decode(Model.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
