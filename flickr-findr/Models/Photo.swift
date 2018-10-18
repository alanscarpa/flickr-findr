//
//  Photo.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

struct Photo: Codable {
    var title = ""
    
    init(title: String) {
        self.title = title
    }
}
