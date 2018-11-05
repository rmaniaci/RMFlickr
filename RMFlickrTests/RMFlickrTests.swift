//
//  RMFlickrTests.swift
//  RMFlickrTests
//
//  Created by Ross Maniaci on 11/2/18.
//  Copyright © 2018 Ross Maniaci. All rights reserved.
//

import XCTest
@testable import RMFlickr

class RMFlickrTests: XCTestCase {
    var controller: ThumbnailTableViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThumbnailTableViewController") as? ThumbnailTableViewController else {
            return XCTFail("Could not instantiate ThumbnailTableViewController from main storyboard")
        }
        
        controller = vc
        controller.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controller = nil
        super.tearDown()
    }

    func testThumbnailCell() {
        let thumbnailCell = controller.tableView.dequeueReusableCell(withIdentifier: "ThumbnailCell")
        XCTAssertNotNil(thumbnailCell, "Thumbnail Table View Controller should be able to dequeue reusable cell with identifier 'ThumbnailCell'")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            controller.tableView.reloadData()
        }
    }
}
