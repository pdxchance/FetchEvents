//
//  EventsModel.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import Foundation

struct CompactEventModel {
    let events: [CompactEvent]?
}

struct CompactEvent {
    let id: Int?
    let title: String?
    let city: String?
    let state: String?
    let datetime_local: String?
    let image: String?
}
