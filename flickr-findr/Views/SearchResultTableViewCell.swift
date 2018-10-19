
//
//  SearchResultTableViewCell.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit

protocol FFTableViewCell {
    static var nibName: String { get }
}

class SearchResultTableViewCell: UITableViewCell, FFTableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var nibName = "SearchResultTableViewCell"
    
    var photo: Photo? {
        didSet {
            updateUI()
        }
    }
    var imageRequest: ImageRequest?
    
    override func prepareForReuse() {
        photoImageView.image = nil
        imageRequest?.cancel()
    }
    
    func updateUI() {
        // todo: this could be more concise
        if let title = photo?.title, !title.isEmpty{
            titleLabel.text = title
        } else {
            titleLabel.text = "Untitled"
        }
        if let url = photo?.url {
            if let downloadedImage = ImageCache.shared.image(fromURL: url) {
                photoImageView.image = downloadedImage
            } else {
                imageRequest = ImageRequest(url: url)
                imageRequest?.load { [weak self] image in
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
