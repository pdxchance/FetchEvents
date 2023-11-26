//
//  EventsViewModel.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import Foundation

public class EventViewModel {
    
    weak var appCordinator: HomeCoordinator?
    
    let event : CompactEvent
    
    init(event : CompactEvent) {
        self.event = event
    }
    
    public var eventTitle : String {
        return event.title ?? ""
    }
    
    public var eventLocation : String {
        let city = event.city ?? ""
        let state = event.state ?? ""
        
        return city + ", " + state
    }
    
    public var eventDateTime : String {
        
        let dateTime = event.datetime_local ?? ""
        
        guard dateTime != "" else {
            return ""
        }
        
        return convertUTC(timestamp: dateTime)!

    }
    
    public var image: String {
        return event.image ?? ""
    }
}
