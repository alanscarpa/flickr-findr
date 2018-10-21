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
        loadPhoto()
    }
    
    private func loadPhoto() {
        guard let url = photo?.url else { return }
        if let downloadedImage = ImageCache.shared.image(fromURL: url) {
            photoImageView.image = downloadedImage
        } else {
            ImageRequest(url: url).load { [weak self] result in
                switch result {
                case .success(let image):
                    guard let image = image else { return }
                    self?.photoImageView?.image = image
                case .failure(let error):
                    let alertVC = UIAlertController.createSimpleAlert(withTitle: error.title, message: error.description)
                    self?.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }

}
