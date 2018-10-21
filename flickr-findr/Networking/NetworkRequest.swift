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
        guard dataTask?.state != .completed else { return }
        dataTask?.cancel()
    }
}

protocol NetworkRequestProtocol {
    associatedtype Object
    func load(withCompletion completion: @escaping (NetworkResult<Object?>) -> Void)
    func decode(_ data: Data) -> Object?
    func cancel()
}

extension NetworkRequestProtocol {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (NetworkResult<Object?>) -> Void) -> URLSessionDataTask {
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil,
                                 delegateQueue: .main)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(self.handleError(error))
            } else {
                guard let data = data else { completion(.failure(.blankDataReturned)); return }
                completion(.success(self.decode(data)))
            }
        }
        task.resume()
        return task
    }
    
    fileprivate func handleError(_ error: Error) -> (NetworkResult<Object?>) {
        if (error as NSError).code == -999 {
            // -999 is called when we cancel download task.  no-op
            return .success(nil)
        } else {
            return .failure(FFError.externalError(error.localizedDescription))
        }
    }
}

extension ApiRequest: NetworkRequestProtocol {
    func load(withCompletion completion: @escaping (NetworkResult<Resource.Model?>) -> Void) {
        dataTask = load(resource.url, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> Resource.Model? {
        return resource.makeModel(data: data)
    }
}

extension ImageRequest: NetworkRequestProtocol {
    func load(withCompletion completion: @escaping (NetworkResult<UIImage?>) -> Void) {
        dataTask = load(url, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
