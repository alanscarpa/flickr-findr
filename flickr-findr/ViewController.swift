//
//  ViewController.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        GetPhotos(forSearchTerm: "dog").execute(dispatcher: URLSessionNetworkDispatcher()) { (result) in
//            print(result)
//        }
        
        let searchRequest = RequestType.search("dog")
        NetworkManager.request(searchRequest) { (result) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // NetworkManager.request(searchRequest) {
                // succes
                // update images and reload
                // failure - notify user
        // }
    }
}


