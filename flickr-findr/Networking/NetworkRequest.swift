//
//  NetworkManager.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation
import UIKit

class NetworkRequest {
    var dataTask: URLSessionDataTask?
    func cancel() {
        dataTask?.cancel()
    }
}

protocol NetworkRequestProtocol {
    associatedtype Object
    func load(withCompletion completion: @escaping (Object?) -> Void)
    func decode(_ data: Data) -> Object?
    func cancel()
}

extension NetworkRequestProtocol {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (Object?) -> Void) -> URLSessionDataTask {
        let configuration = URLSessionConfiguration.default
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
        return task
    }
}

extension ApiRequest: NetworkRequestProtocol {
    func load(withCompletion completion: @escaping (Resource.Model?) -> Void) {
        dataTask = load(resource.url, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> Resource.Model? {
        return resource.makeModel(data: data)
    }
}

extension ImageRequest: NetworkRequestProtocol {
    func load(withCompletion completion: @escaping (UIImage?) -> Void) {
        dataTask = load(url, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
