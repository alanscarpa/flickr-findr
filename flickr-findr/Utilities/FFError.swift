//
//  FFError.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/21/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

enum FFError: Error {
    case blankDataReturned
    case externalError(String)
    
    var title: String {
        switch self {
        case .blankDataReturned:
            return "No Data"
        case .externalError(_):
            return "Error"
        }
    }
    
    var description: String {
        switch self {
        case .blankDataReturned:
            return "Unable to get data."
        case .externalError(let localizedDescription):
            return localizedDescription
        }
    }
}

