//
//  Utils.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import Foundation

func convertUTC(timestamp : String?) -> String? {
    //return "Aug 9, 2018 - 4:24 PM"
    
    let targetDate = timestamp ?? ""

    // convert ISO to date object
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    if let eventDate = dateFormatter.date(from:targetDate) {
        let simpleFormatter = DateFormatter()
        simpleFormatter.locale = Locale(identifier: "en_US_POSIX")
        simpleFormatter.dateFormat = "MMM d, h:mm a"
        return simpleFormatter.string(from: eventDate)
    } else {
        return ""
    }
}
