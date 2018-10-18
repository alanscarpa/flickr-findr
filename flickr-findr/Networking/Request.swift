//
//  Request.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//
import Foundation




struct GetPhotos: RequestTypee {
    typealias ResponseType = [Photo]
    private var searchTerm = ""
    private var page = 1
    init(forSearchTerm searchTerm: String, page: Int = 1) {
        self.searchTerm = searchTerm
        self.page = page
    }
    var data: RequestData {
        return RequestData(path: "https://api.flickr.com/services/rest/",
                           method: .get,
                           headers: [:],
                           parameters: ["method": "flickr.photos.search",
                                        "api_key": flickrAPIKey,
                                        "format" : "json",
                                        "per_page": 25,
                                        "page" : page,
                                        "text": searchTerm])
    }
}

typealias RequestHeaders = [String: String]
typealias RequestParameters = [String: Any]

enum HTTPMethod: String {
    case get = "GET"
}

struct RequestData {
    let path: String
    let method: HTTPMethod
    let headers: RequestHeaders
    let parameters: RequestParameters?
    
    init(path: String,
         method: HTTPMethod,
         headers: RequestHeaders,
         parameters: RequestParameters?) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
}

protocol RequestTypee {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}

extension RequestTypee {
    func execute(dispatcher: NetworkDispatcher, completion: @escaping (Result<ResponseType>) -> Void) {
        dispatcher.dispatch(request: data) { (result) in
            switch result {
            case .success(let responseData):
                do {
                    let result = try JSONDecoder().decode(ResponseType.self, from: responseData)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
