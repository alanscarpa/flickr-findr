//
//  Photo.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//
import Foundation

protocol ApiResource: Decodable {
    var url: URL { get }
}

extension Photos {
    
}
struct Photos: ApiResource {
    // TODO: use a component builder
    var url: URL = URL(string: "https://api.flickr.com/services/rest?api_key=1508443e49213ff84d566777dc211f2a&method=flickr.photos.search&format=json&per_page=26&page=1&tags=dog&nojsoncallback=1")!
    
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

