//
//  DataManager.swift
//  flickr-findr
//
//  Created by Alan Scarpa on 10/19/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import RealmSwift

class DataManager {
    
    static func addSearchTerm(_ searchTerm: SearchTerm, realm: Realm = try! Realm()) {
        if realm.objects(SearchTerm.self).filter({ $0.query == searchTerm.query }).isEmpty {
            try! realm.write {
                realm.add(searchTerm)
            }
        }
    }
    
    static func getSearchedTerms(_ realm: Realm = try! Realm()) -> [SearchTerm] {
        return realm.objects(SearchTerm.self).map{ $0 }.reversed()
    }
}
