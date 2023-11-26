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
                    let json = try? JSONDecoder().decode(CompactEventModel.self, from: data)
                    
                    let events = json?.events ?? []
                    self.events = events
                    
                    let totalRecs = json?.meta?.total ?? 0
                    self.totalRecs = totalRecs
                        
                    self.pageNum += 1

                    completion(events)
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

        let event = CompactEvent(id: 1, title: "", city: "", state: "", datetime_local: "", image: "", performers: nil)
        let events = [event]
        
        completion(events)
    }
}

