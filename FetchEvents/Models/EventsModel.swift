//
//  EventsModel.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let eventModel = try? newJSONDecoder().decode(EventModel.self, from: jsonData)

import Foundation

struct CompactEventModel {
    let events: [CompactEvent]?
    let meta: Meta?
}

struct CompactEvent {
    let id: Int?
    let title: String?
    let city: String?
    let state: String?
    let datetime_local: String?
    let image: String?
}

// MARK: - EventModel
struct EventModel: Codable {
    let events: [Event]?
    let meta: Meta?
    let inHand: InHand?
}

// MARK: - Event
struct Event: Codable {
    let type: String?
    let id: Int?
    let datetimeUTC: String?
    let venue: Venue?
    let datetimeTbd: Bool?
    let performers: [Performer]?
    let isOpen: Bool?
    let links: [String]?
    let datetime_local: String?
    let timeTbd: Bool?
    let shortTitle, visibleUntilUTC: String?
    let stats: EventStats?
    let taxonomies: [Taxonomy]?
    let url: String?
    let score: Double?
    let announceDate, createdAt: String?
    let dateTbd: Bool?
    let title: String?
    let popularity: Double?
    let eventDescription: String?
    let status: Status?
    let accessMethod: AccessMethod?
    let eventPromotion: Bool?
    let announcements: Announcements?
    let conditional: Bool?
    let datetime_utc: String?
    let themes, domainInformation: [String]?
}

// MARK: - AccessMethod
struct AccessMethod : Codable {
    let method: Method?
    let createdAt: Date?
    let employeeOnly: Bool?
}

enum Method: String, Codable {
    case pdf417
    case qrcodeTm
}

// MARK: - Announcements
struct Announcements: Codable {
    let key: String?
    let checkoutDisclosures: CheckoutDisclosures?
}

// MARK: - CheckoutDisclosures
struct CheckoutDisclosures: Codable {
    let messages: [Message]?
}

// MARK: - Message
struct Message: Codable {
    let text: String?
}

// MARK: - Performer
struct Performer: Codable {
    let type, name: String?
    let image: String?
    let id: Int?
    let images: PerformerImages?
    let divisions: [Division]?
    let hasUpcomingEvents, primary: Bool?
    let stats: PerformerStats?
    let taxonomies: [Taxonomy]?
    let imageAttribution: String?
    let url: String?
    let score: Double?
    let slug: String?
    let homeVenueID: Int?
    let shortName: String?
    let numUpcomingEvents: Int?
    let colors: Colors?
    let imageLicense: String?
    let popularity: Int?
    let homeTeam: Bool?
    let location: Location?
    let genres: [Genre]?
    let awayTeam: Bool?
}

// MARK: - Colors
struct Colors: Codable {
    let all: [String]?
    let iconic: String?
    let primary: [String]?
}

// MARK: - Division
struct Division: Codable {
    let taxonomyID: Int?
    let shortName: String?
    let displayName: String?
    let displayType: DisplayType?
    let divisionLevel: Int?
    let slug: String?
}

enum DisplayType: String, Codable {
    case conference
    case division
    case league
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name, slug: String?
    let primary: Bool?
    let images: GenreImages?
    let image: String?
    let documentSource: DocumentSource?
}

// MARK: - DocumentSource
struct DocumentSource: Codable {
    let sourceType: SourceType?
    let generationType: GenerationType?
}

enum GenerationType: String, Codable {
    case full
}

enum SourceType: String, Codable {
    case elastic
}

// MARK: - GenreImages
struct GenreImages: Codable {
    let the1200X525, the1200X627, the136X136, the500_700: String?
    let the800X320, banner, block, criteo130_160: String?
    let criteo170_235, criteo205_100, criteo400_300, fb100X72: String?
    let fb600_315, huge, ipadEventModal, ipadHeader: String?
    let ipadMiniExplore, mongo, squareMid, triggitFbAd: String?
}

// MARK: - PerformerImages
struct PerformerImages: Codable {
    let huge: String?
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double?
}

// MARK: - PerformerStats
struct PerformerStats: Codable {
    let eventCount: Int?
}

// MARK: - Taxonomy
struct Taxonomy: Codable {
    let id: Int?
    let name: String?
    let parentID: Int?
    let documentSource: DocumentSource?
    let rank: Int?
}

// MARK: - EventStats
struct EventStats: Codable {
    let listingCount, averagePrice, lowestPriceGoodDeals, lowestPrice: Int?
    let highestPrice, visibleListingCount: Int?
    let dqBucketCounts: DqBucketCounts?
    let medianPrice, lowestSgBasePrice, lowestSgBasePriceGoodDeals: Int?
}

enum DqBucketCounts: String, Codable {
    case dummmy
}

enum Status: String, Codable{
    case normal
}

// MARK: - Venue
struct Venue: Codable {
    let state, nameV2, postalCode, name: String?
    let links: [String]?
    let timezone: String?
    let url: String?
    let score: Double?
    let location: Location?
    let address: String?
    let country: String?
    let hasUpcomingEvents: Bool?
    let numUpcomingEvents: Int?
    let city, slug, extendedAddress: String?
    let id, popularity: Int?
    let accessMethod: AccessMethod?
    let metroCode, capacity: Int?
    let displayLocation: String?
}

enum Country: String, Codable {
    case us
}

enum Timezone: String, Codable {
    case americaChicago
    case americaLosAngeles
    case americaNewYork
}

// MARK: - InHand
struct InHand: Codable {
}

// MARK: - Meta
struct Meta : Codable {
    let total, took, page, perPage: Int?
    let geolocation: String?
}

