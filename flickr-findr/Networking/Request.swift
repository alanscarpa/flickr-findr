//
//  Request.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//
import Foundation

typealias RequestHeaders = [String: String]
typealias RequestParameters = [String: Any]

enum HTTPMethod: String {
    case get = "GET"
}

struct Request {
    let path: String
    let method: HTTPMethod
    let headers: RequestHeaders
    let parameters: RequestParameters
    
    init(path: String,
         method: HTTPMethod,
         headers: RequestHeaders,
         parameters: RequestParameters) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
}
