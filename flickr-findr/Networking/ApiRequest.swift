//
//  ApiRequest.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

struct ApiRequest<Resource: ApiResource> {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}
