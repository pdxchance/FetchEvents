//
//  EventsAPIManager.swift
//  FetchEvents
//
//  Created by Deanne Chance on 2/19/22.
//

import Foundation

private let clientId = "MjIwMjcyMDJ8MTYyMjA0OTEzNi4yMjU5NDk1"
private let secret = "2673489515885151c07951a10eb5de55e02b3da5e8eb5ee3c23d784f0f44e91c"

typealias eventCompletionHandler = ([Event], Int) -> Void

class EventsApiManager {
    
    let session = URLSession.shared

    static let shared = EventsApiManager()
    private init() {}
    
    var pageNumber = 0
    
    func getEvents(query: String, completion: @escaping eventCompletionHandler) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.seatgeek.com/2/"
        components.path = "/events"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: secret),
            URLQueryItem(name: "page", value: String(pageNumber)),
            URLQueryItem(name: "q", value: query)
        ]
        
        guard let route = URL(string: components.string!)?.host, let params = components.percentEncodedQuery else {
            return
        }
        
        let url = URL(string:"https://\(route)?\(params)")!
        
        let task = session.dataTask(with: url, completionHandler: { [weak self]  (data, response, error) in
            
            do {
                guard let self = self else { return }
                
                self.pageNumber += 1
                
                let payload = try JSONDecoder().decode(EventModel.self, from: data!)
                let events = payload.events ?? []
                let totalRecords = payload.meta?.total ?? 0
                completion(events, totalRecords)
        
            } catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}

class MockApiManager : EventsApiManager {
    
    override func getEvents(query: String, completion: @escaping eventCompletionHandler) {

        let event = Event(type: "", id: 1, datetimeUTC: "", venue: nil, datetimeTbd: false, performers: nil, isOpen: false, links: nil, datetime_local: "", timeTbd: false, shortTitle: "", visibleUntilUTC: "", stats: nil, taxonomies: nil, url: "", score: 0, announceDate: "", createdAt: "", dateTbd: true, title: "Some Event", popularity: 0, eventDescription: "", status: nil, accessMethod: nil, eventPromotion: false, announcements: nil, conditional: false, datetime_utc: "", themes: nil, domainInformation: nil)
        let events = [event]
        
        completion(events, events.count)
    }
}
