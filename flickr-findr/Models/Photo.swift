//
//  Photo.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

struct Photos: Decodable {
    let page: Int
    let pages: Int
    let photo: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos
        case page
        case pages
        case photo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photos = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        page = try photos.decode(Int.self, forKey: .page)
        pages = try photos.decode(Int.self, forKey: .pages)
        var photoObjectsArray = try photos.nestedUnkeyedContainer(forKey: .photo)
        var photoObjects = [Photo]()
        while !photoObjectsArray.isAtEnd {
            try photoObjects.append(photoObjectsArray.decode(Photo.self))
        }
        photo = photoObjects
    }
}

struct Photo: Codable {
    let id: String
    let title: String
}

