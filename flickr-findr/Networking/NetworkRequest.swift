//
//  NetworkManager.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkRequest {
    associatedtype Object
    func load(withCompletion completion: @escaping (Object?) -> Void)
    func decode(_ data: Data) -> Object?
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (Object?) -> Void) {
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

extension ApiRequest: NetworkRequest {
    func load(withCompletion completion: @escaping (Resource.Model?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> Resource.Model? {
        return resource.makeModel(data: data)
    }
}

extension ImageRequest: NetworkRequest {
    func load(withCompletion completion: @escaping (UIImage?) -> Void) {
        load(url, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
