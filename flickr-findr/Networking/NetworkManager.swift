//
//  NetworkManager.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation
import UIKit

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

protocol NetworkRequest {
    associatedtype Model
    func load(withCompletion completion: @escaping (Model?) -> Void)
    func decode(_ data: Data) -> Model?
}

extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (Model?) -> Void) {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription) // todo
            } else {
                guard let data = data else { completion(nil); return }
                completion(self.decode(data))
            }
        }
        task.resume()
    }
}

class ImageRequest: NetworkRequest {
    typealias Model = UIImage
    func load(withCompletion completion: @escaping (Model?) -> Void) {
        load(url, withCompletion: completion)
    }
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    let url: URL
    init(url: URL) {
        self.url = url
    }
}
