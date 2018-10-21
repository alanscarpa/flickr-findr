//
//  UIAlertController+FF.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/21/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func createSimpleAlert(withTitle title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
