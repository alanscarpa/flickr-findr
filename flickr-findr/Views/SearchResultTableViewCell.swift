
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
    
    func updateUI() {
        // todo: this could be more concise
        if let title = photo?.title, !title.isEmpty{
            titleLabel.text = title
        } else {
            titleLabel.text = "Untitled"
        }
    }
}
