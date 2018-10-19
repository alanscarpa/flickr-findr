//
//  Result.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

// todo: implement
public enum Result<T> {
    case success(T)
    case failure(Error)
}
