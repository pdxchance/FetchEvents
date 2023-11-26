//
//  EventsModel.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import Foundation

struct CompactEventModel : Codable{
    let events: [CompactEvent]?
    let meta: MetaData?
}

struct CompactEvent: Codable {
    let id: Int?
    let title: String?
    let city: String?
    let state: String?
    let datetime_local: String?
    let image: String?
    let performers: [PerformersNode]?
}

struct PerformersNode: Codable {
    let image: String?
}

struct MetaData: Codable {
    let total: Int
    let took: Int
    let page: Int
    let per_page: Int
}
