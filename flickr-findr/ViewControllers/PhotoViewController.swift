//
//  PhotoViewController.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    var photo: Photo?
    
    convenience init(_ photo: Photo) {
        self.init()
        self.photo = photo
        title = photo.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = photo?.url {
            if let downloadedImage = ImageCache.shared.image(fromURL: url) {
                photoImageView.image = downloadedImage
            } else {
                ImageRequest(url: url).load { [weak self] image in
                    guard let image = image else { return }
                    ImageCache.shared.put(image: image, withURL: url)
                    self?.photoImageView?.image = image
                }
            }
        } else {
            photoImageView.image = nil
        }
    }

}
