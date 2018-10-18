//
//  NetworkDispatcher.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

protocol NetworkDispatcher {
    func dispatch(request: RequestData, completion: @escaping (Result<Data>) -> Void)
}

struct URLSessionNetworkDispatcher: NetworkDispatcher {    
    func dispatch(request: RequestData, completion: @escaping (Result<Data>) -> Void) {
        guard let url = URL(string: request.path) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        do {
            if let parameters = request.parameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            }
        } catch {
            completion(.failure(error))
            return
        }
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
