//
//  SearchTerm.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import RealmSwift

class SearchTerm: Object {
    @objc dynamic var query = ""
    
    convenience init(_ query: String) {
        self.init()
        self.query = query.lowercased()
    }
    
    override static func primaryKey() -> String? {
        return "query"
    }
}
