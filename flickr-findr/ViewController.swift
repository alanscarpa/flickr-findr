//
//  ViewController.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var request: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let photosResource = PhotosResource(searchTerm: "dog")
        let photosRequest = ApiRequest(resource: photosResource)
        request = photosRequest
        photosRequest.load { (photos) in
            print(photos)
        }
    }
}


