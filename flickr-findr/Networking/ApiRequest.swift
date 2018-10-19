//
//  ApiRequest.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

class ApiRequest<Resource: ApiResource>: NetworkRequest {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}
