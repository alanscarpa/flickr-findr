//
//  ApiRequest.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

class ApiRequest<Resource: ApiResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension ApiRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.Model? {
        return resource.makeModel(data: data)
    }
    
    func load(withCompletion completion: @escaping (Resource.Model?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}
