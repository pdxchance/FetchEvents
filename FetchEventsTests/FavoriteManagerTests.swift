//
//  FavoriteManagerTests.swift
//  FetchEventsTests
//
//  Created by Deanne Chance on 2/19/22.
//

import XCTest
@testable import FetchEvents

class FavoriteManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddingFavorites() throws {
        
        let manager = FavoritesManager()
        manager.clearFavorites()
        
        let event1 = Event(type: "", id: 1, datetimeUTC: "", venue: nil, datetimeTbd: false, performers: nil, isOpen: false, links: nil, datetime_local: "", timeTbd: false, shortTitle: "", visibleUntilUTC: "", stats: nil, taxonomies: nil, url: "", score: 0, announceDate: "", createdAt: "", dateTbd: true, title: "Some Event", popularity: 0, eventDescription: "", status: nil, accessMethod: nil, eventPromotion: false, announcements: nil, conditional: false, datetime_utc: "", themes: nil, domainInformation: nil)
        
        
        let event2 = Event(type: "", id: 666, datetimeUTC: "", venue: nil, datetimeTbd: false, performers: nil, isOpen: false, links: nil, datetime_local: "", timeTbd: false, shortTitle: "", visibleUntilUTC: "", stats: nil, taxonomies: nil, url: "", score: 0, announceDate: "", createdAt: "", dateTbd: true, title: "Some Event", popularity: 0, eventDescription: "", status: nil, accessMethod: nil, eventPromotion: false, announcements: nil, conditional: false, datetime_utc: "", themes: nil, domainInformation: nil)
        
        
        let event3 = Event(type: "", id: 8, datetimeUTC: "", venue: nil, datetimeTbd: false, performers: nil, isOpen: false, links: nil, datetime_local: "", timeTbd: false, shortTitle: "", visibleUntilUTC: "", stats: nil, taxonomies: nil, url: "", score: 0, announceDate: "", createdAt: "", dateTbd: true, title: "Some Event", popularity: 0, eventDescription: "", status: nil, accessMethod: nil, eventPromotion: false, announcements: nil, conditional: false, datetime_utc: "", themes: nil, domainInformation: nil)

        let favorite1 = Favorite(id: 1)
        let favorite2 = Favorite(id: 666)
        
        // Test Adding
        manager.addFavorite(favorite: favorite1)
        manager.addFavorite(favorite: favorite2)
        let favorites = manager.getFavorites()
        XCTAssert(favorites.count == 2)
        
        // Test is Favorite
        XCTAssert(manager.isFavorite(event: event1) == true)
        XCTAssert(manager.isFavorite(event: event2) == true)
        
        // Test is not Favorite
        XCTAssert(manager.isFavorite(event: event3) == false)
        
        //Test removing
        manager.removeFavorite(event: event1)
        let favorites2 = manager.getFavorites()
        XCTAssert(favorites2.count == 1)
        
        //Test is favorite is false, this favorite was just removed
        XCTAssert(manager.isFavorite(event: event1) == false)
        
        //Test remaining favorite
        XCTAssert(manager.isFavorite(event: event2) == true)
        
        //Remove last node
        manager.removeFavorite(event: event2)
        let favorites3 = manager.getFavorites()
        XCTAssert(favorites3.count == 0)
        
        //Test removing empty list
        manager.removeFavorite(event: event2)
        let favorites4 = manager.getFavorites()
        XCTAssert(favorites4.count == 0)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
