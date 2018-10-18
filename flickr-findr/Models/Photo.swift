//
//  Photo.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

struct Photo: Decodable {
    var id = ""
    var title = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case photos = "photos"
        case photo = "photo"
    }
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photos = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        let photo = try photos.nestedContainer(keyedBy: CodingKeys.self, forKey: .photo)
        id = try photo.decode(String.self, forKey: .id)
        title = try photo.decode(String.self, forKey: .title)
    }
}

