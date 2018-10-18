//
//  PhotosResource.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

struct PhotosResource: ApiResource {
    // ApiResource Protocol
    typealias Model = Photos
    var parameters: [URLQueryItem] {
        return [URLQueryItem(name: "tags", value: searchTerm),
                URLQueryItem(name: "method", value: "flickr.photos.search")]
    } 
    let searchTerm: String
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
    }
}
