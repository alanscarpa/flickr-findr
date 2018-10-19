//
//  PhotosResource.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

struct PhotosResource {
    let searchTerm: String
    init(searchTerm: String) {
        self.searchTerm = searchTerm
    }
}

extension PhotosResource: ApiResource {
    typealias Model = PhotosContainer
    var parameters: [URLQueryItem] {
        return [URLQueryItem(name: "tags", value: searchTerm),
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "per_page", value: "25"),
                URLQueryItem(name: "page", value: "1")]
    }
}
