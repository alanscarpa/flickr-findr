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

        
        let searchRequest = RequestType.search("dog")
        NetworkManager.request(searchRequest) { (result) in
            switch result {
            case .success(let data):
                do {
                    let photos = try JSONDecoder().decode(Photos.self, from: data)
                    print(photos)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let photosResource = Photos
//        Webservice().load(resource: <#T##Resource<T>#>) { (<#Result<T>#>) in
//            <#code#>
//        }
    }
}


