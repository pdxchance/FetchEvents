//
//  FetchEventsTests.swift
//  FetchEventsTests
//
//  Created by Deanne Chance on 5/28/21.
//

import XCTest
@testable import FetchEvents

class FetchEventsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() throws {
        let node = Event(type: "", id: 1, datetimeUTC: "", venue: nil, datetimeTbd: false, performers: nil, isOpen: false, links: nil, datetime_local: "", timeTbd: false, shortTitle: "", visibleUntilUTC: "", stats: nil, taxonomies: nil, url: "", score: 0, announceDate: "", createdAt: "", dateTbd: true, title: "Some Event", popularity: 0, eventDescription: "", status: nil, accessMethod: nil, eventPromotion: false, announcements: nil, conditional: false, datetime_utc: "", themes: nil, domainInformation: nil)
        
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
