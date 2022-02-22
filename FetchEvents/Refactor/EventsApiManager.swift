//
//  EventsAPIManager.swift
//  FetchEvents
//
//  Created by Deanne Chance on 2/19/22.
//

import Foundation

private let clientId = "MjIwMjcyMDJ8MTYyMjA0OTEzNi4yMjU5NDk1"
private let secret = "2673489515885151c07951a10eb5de55e02b3da5e8eb5ee3c23d784f0f44e91c"

typealias eventCompletionHandler = ([CompactEvent]) -> Void

class EventsApiManager {
    
    private let session = URLSession.shared

    static let shared = EventsApiManager()
    private init() {}
    
    private var events = [CompactEvent]()
    
    private var pageNum = 1
    private var totalRecs = 0
    
    func queryEvents(query: String, completion: @escaping eventCompletionHandler) {
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: String(pageNum)),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: secret)
        ]
        
        guard let queryString = components.percentEncodedQuery else {
            return
        }
        
        let url = URL(string:"https://api.seatgeek.com/2/events?\(queryString)")!
        
        let task = session.dataTask(with: url, completionHandler: { [weak self]  (data, response, error) in
            
            do {
                guard let self = self, let data = data else { return }
                                
                do {
                    // make sure this JSON is in the format we expect
                    if let eventModel = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        
                        let events = eventModel["events"] as! [[String:Any]]
                        
                        for event in events {
                            let id = event["id"] as! Int
                            let title = event["title"] as! String
                            
                            let venue = event["venue"] as! [String: Any]
                            let city = venue["state"] as! String
                            let state = venue["city"] as! String
                            
                            let datetime = event["datetime_local"] as! String
                            
                            let performers = event["performers"] as! [[String: Any]]
                            let performer = performers[0]
                            let image = performer["image"] as! String
                        
                            let compactEvent = CompactEvent(id: id, title: title, city: city, state: state, datetime_local: datetime, image: image)
                            self.events.append(compactEvent)
                        }
                        
                        let meta = eventModel["meta"] as! [String:Any]
                        let totalRecs = meta["total"] as! Int
                        self.totalRecs = totalRecs
                        
                        self.pageNum += 1
                        completion(self.events)
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        })
        task.resume()
    }
    
    func getEvent(index: Int) -> CompactEvent? {
        
        guard index < events.count else {
            return nil
        }
        
        return events[index]
    }
    
    func reset() {
        events = []
        pageNum = 1
        totalRecs = 0
    }
    
    func getArrayCount() -> Int {
        return events.count
    }
    
    func getTotalRecords() -> Int {
        return self.totalRecs
    }
}

class MockApiManager : EventsApiManager {
    
    override func queryEvents(query: String, completion: @escaping eventCompletionHandler) {

        let event = CompactEvent(id: 1, title: "", city: "", state: "", datetime_local: "", image: "")
        let events = [event]
        
        completion(events)
    }
}

