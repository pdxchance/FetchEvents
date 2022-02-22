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
                        
                        let events = eventModel["events"] as! [Event] //{
                            
                            self.events += events.map({ event in
                                return CompactEvent(id: event.id, title: event.title, city: event.venue?.city, state: event.venue?.state, datetime_local: event.datetime_local, image: event.performers?[0].image)
                            })
                            
                            if let meta = eventModel["meta"] as? Meta {
                                self.totalRecs = meta.total ?? 0

                            }
                            self.pageNum += 1
                            completion(self.events)
                        //}
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                

        
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

