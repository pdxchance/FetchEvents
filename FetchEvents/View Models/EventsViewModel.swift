//
//  EventsViewModel.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import Foundation

public class EventViewModel {
    
    private let event : Event
    
    init(event : Event) {
        self.event = event
    }
    
    public var eventTitle : String {
        return event.title ?? ""
    }
    
    public var eventLocation : String {
        let city = event.venue?.city ?? ""
        let state = event.venue?.state ?? ""
        
        return city + ", " + state
    }
    
    public var eventDateTime : String {
        
        let dateTime = event.datetime_utc ?? ""
        
        guard dateTime != "" else {
            return ""
        }
        
        return convertUTC(timestamp: dateTime)!

    }
}
