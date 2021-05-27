//
//  EventsViewController.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

class EventsViewController: UIViewController {
    
    let cellReuseID = "cellReuseID"
    
    var events : [Event] = []
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    let tableView : UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: cellReuseID)

        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        tableView.anchor(top: searchBar.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        let params : [String: Any] = [:]
        loadData(params: params)
    }

}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension EventsViewController {
    func loadData(params : [String: Any]) {
        
        let session = URLSession.shared
        
        let queryParams = "client_id=" + clientId + "&" + "client_secret=" + secret
        let url = URL(string: baseUrl + eventsEndpoint + "?" + queryParams)!
        

        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            do {
                
                let payload = try JSONDecoder().decode(EventModel.self, from: data!)
                self.events = payload.events ?? []
                
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
