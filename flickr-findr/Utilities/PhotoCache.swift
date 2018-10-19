//
//  PhotoCache.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private init(){}
    private let cache = NSCache<NSString, UIImage>()
    
    func image(fromURL url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
    
    func put(image: UIImage, withURL url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
