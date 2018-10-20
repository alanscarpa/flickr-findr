//
//  flickr_findrTests.swift
//  flickr-findrTests
//
//  Created by Alan Scarpa on 10/17/18.
//  Copyright © 2018 alanscarpa. All rights reserved.
//

import XCTest

@testable import flickr_findr

class ViewControllerTests: XCTestCase {
    
    var rootVCUnderTest: RootViewController!
    var searchVCUnderTest: SearchTableViewController!
    var navigationVC: UINavigationController!
    
    override func setUp() {
        rootVCUnderTest = RootViewController()
        _ = rootVCUnderTest.view
        searchVCUnderTest = SearchTableViewController()
        navigationVC = UINavigationController()
        navigationVC.viewControllers = [searchVCUnderTest]
        _ = searchVCUnderTest.view
    }

    override func tearDown() {
        rootVCUnderTest = nil
        searchVCUnderTest = nil
        navigationVC = nil
    }
    
    func test_rootVC_has_one_VC() {
        XCTAssert(rootVCUnderTest.viewControllers.count == 1)
    }
    
    func test_rootViewController_has_searchViewController_as_first_viewController() {
        XCTAssert(rootVCUnderTest.viewControllers.first is SearchTableViewController)
    }

    func test_searchViewController_title_is_flickrFindr() {
        XCTAssertEqual(searchVCUnderTest.title, "Flickr Findr")
    }
    
    func test_searchViewController_cellHeight() {
        XCTAssertEqual(searchVCUnderTest.tableView.rowHeight, 100)
    }

}
