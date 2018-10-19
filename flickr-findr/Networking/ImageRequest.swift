//
//  ImageRequest.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit

class ImageRequest: NetworkRequest {
    let url: URL
    init(url: URL) {
        self.url = url
    }
}
