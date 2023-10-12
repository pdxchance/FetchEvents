//
//  FetchEventsTests.swift
//  FetchEventsTests
//
//  Created by Deanne Chance on 5/28/21.
//

import XCTest
@testable import FetchEvents

class FetchEventViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() throws {
        let node = CompactEvent(id: 1, title: "Some Event", city: "Chicago", state: "Illinois", datetime_local: "", image: "")
        
        let viewModel = EventViewModel(event: node)
        
        
        XCTAssert(viewModel.eventTitle == "Some Event")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
