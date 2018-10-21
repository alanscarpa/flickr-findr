//
//  Result.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case failure(FFError)
}
