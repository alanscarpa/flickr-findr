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
    var photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photosWrapper = "photos"
        case page
        case photos = "photo"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photosWrapper = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photosWrapper)
        page = try photosWrapper.decode(Int.self, forKey: .page)
        var photoObjectsArray = try photosWrapper.nestedUnkeyedContainer(forKey: .photos)
        var photoObjects = [Photo]()
        while !photoObjectsArray.isAtEnd {
            try photoObjects.append(photoObjectsArray.decode(Photo.self))
        }
        photos = photoObjects
    }
    
    func update(with photosContainer: PhotosContainer?) {
        if let newPhotos = photosContainer?.photos, let page = photosContainer?.page {
            self.page = page
            if page == 1 {
                self.photos = newPhotos
            } else {
                self.photos.append(contentsOf: newPhotos)
            }
        }
    }
}
