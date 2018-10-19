//
//  Photo.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/18/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

struct Photo: Codable {
    let id: String
    let title: String
    let farm: Int
    let server: String
    let secret: String
}
