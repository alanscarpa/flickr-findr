//
//  flickr_findrTests.swift
//  flickr-findrTests
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import XCTest
@testable import flickr_findr

class flickr_findrTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_rootVC_has_one_VC() {
        let rootVCUnderTest = RootViewController()
        _ = rootVCUnderTest.view
        XCTAssert(rootVCUnderTest.viewControllers.count == 1)
    }
    
    func test_rootViewController_has_searchViewController_as_first_viewController() {
        let rootVCUnderTest = RootViewController()
        _ = rootVCUnderTest.view
        XCTAssert(rootVCUnderTest.viewControllers.first is SearchTableViewController)
    }

    func test_searchViewController_title_is_flickrFindr() {
        let searchVCUnderTest = SearchTableViewController()
        let navigationVC = UINavigationController()
        navigationVC.viewControllers = [searchVCUnderTest]
        _ = searchVCUnderTest.view
        XCTAssertEqual(searchVCUnderTest.title, "Flickr Findr")
    }
    
    func test_searchViewController_cellHeight() {
        let searchVCUnderTest = SearchTableViewController()
        let navigationVC = UINavigationController()
        navigationVC.viewControllers = [searchVCUnderTest]
        _ = searchVCUnderTest.view
        XCTAssertEqual(searchVCUnderTest.tableView.rowHeight, 100)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
