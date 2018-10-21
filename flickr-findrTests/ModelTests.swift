//
//  ModelTests.swift
//  flickr-findrTests
//
//  Created by Alan Scarpa on 10/21/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation
import XCTest

@testable import flickr_findr

class ModelTests: XCTestCase {
    
    var photosContainer: PhotosContainer!
    
    override func setUp() {
        let photosRequest = ApiRequest(resource: PhotosResource(searchTerm: "test", page: 1))
        let path = Bundle(for: type(of: self)).path(forResource: "PhotosContainerResponse", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        photosContainer = photosRequest.decode(data)
    }
    
    override func tearDown() {
        photosContainer = nil
    }
    
    func test_photosContainer_update_replaces_photos() {
        photosContainer?.update(with: photosContainer)
        XCTAssertEqual(photosContainer!.photos.count, 25)
    }
    
    func test_photosContainer_update_appends_photos() {
        let photosRequest = ApiRequest(resource: PhotosResource(searchTerm: "test", page: 2))
        let path = Bundle(for: type(of: self)).path(forResource: "PhotosContainerResponsePageTwo", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let photosContainer2 = photosRequest.decode(data)
        photosContainer.update(with: photosContainer2)
        XCTAssertEqual(photosContainer!.photos.first!.title, "Test Title")
        XCTAssertEqual(photosContainer!.photos.count, 50)
    }
    
}
