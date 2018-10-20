//
//  Photo.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation

class PhotosContainer: Decodable {
    var page: Int
    let pages: Int
    var photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photosWrapper = "photos"
        case page
        case pages
        case photos = "photo"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photosWrapper = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photosWrapper)
        page = try photosWrapper.decode(Int.self, forKey: .page)
        pages = try photosWrapper.decode(Int.self, forKey: .pages)
        var photoObjectsArray = try photosWrapper.nestedUnkeyedContainer(forKey: .photos)
        var photoObjects = [Photo]()
        while !photoObjectsArray.isAtEnd {
            try photoObjects.append(photoObjectsArray.decode(Photo.self))
        }
        photos = photoObjects
    }
}
