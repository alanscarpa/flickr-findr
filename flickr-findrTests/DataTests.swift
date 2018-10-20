//
//  DataTests.swift
//  flickr-findrTests
//
//  Created by Alan Scarpa on 10/20/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import XCTest
import RealmSwift

@testable import flickr_findr

class DataTests: XCTestCase {
    
    let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "dataTests"))
    var s1: SearchTerm!
    var s2: SearchTerm!
    var s3: SearchTerm!
    
    override func setUp() {
        try! realm.write {
            s1 = SearchTerm("orange")
            s2 = SearchTerm("sink")
            s3 = SearchTerm("cup")
        }
    }
    
    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func test_dataManager_persists_single_searchTerm() {
        DataManager.addSearchTerm(SearchTerm("test term"), realm: realm)
        let searchTerm = DataManager.getSearchedTerms(realm).first!
        XCTAssertEqual(searchTerm.query, "test term")
    }
    
    func test_dataManager_persists_multiple_searchTerms() {
        DataManager.addSearchTerm(s1, realm: realm)
        DataManager.addSearchTerm(s2, realm: realm)
        DataManager.addSearchTerm(s3, realm: realm)
        XCTAssertEqual(DataManager.getSearchedTerms(realm).count, 3)
    }
    
    func test_dataManager_should_not_persist_duplicate_searchTerms() {
        DataManager.addSearchTerm(s1, realm: realm)
        DataManager.addSearchTerm(s1, realm: realm)
        XCTAssertEqual(DataManager.getSearchedTerms(realm).count, 1)
    }
}
