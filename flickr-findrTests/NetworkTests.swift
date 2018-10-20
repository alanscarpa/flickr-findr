//
//  NetworkTests.swift
//  flickr-findrTests
//
//  Created by Alan Scarpa on 10/20/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import Foundation
import XCTest

@testable import flickr_findr

class NetworkTests: XCTestCase {

    func test_photos_request_goes_to_correct_url() {
        let photosRequest = ApiRequest(resource: PhotosResource(searchTerm: "test", page: 1))
        let expectedUrl = "https://api.flickr.com/services/rest?api_key=1508443e49213ff84d566777dc211f2a&format=json&nojsoncallback=1&tags=test&method=flickr.photos.search&per_page=25&page=1"
        XCTAssertEqual(photosRequest.resource.url.absoluteString, expectedUrl)
    }
    
    func test_photos_response_is_parsed_correctly() {
        let photosRequest = ApiRequest(resource: PhotosResource(searchTerm: "test", page: 1))
        let path = Bundle(for: type(of: self)).path(forResource: "PhotosContainerResponse", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let photosContainer = photosRequest.decode(data)
        XCTAssert(photosContainer != nil)
        XCTAssertEqual(photosContainer!.photos.first!.title, "Test Title")
    }
    
}
