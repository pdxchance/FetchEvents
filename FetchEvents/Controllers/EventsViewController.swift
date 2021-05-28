//
//  EventsViewController.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit
import Kingfisher
import CRRefresh

class EventsViewController: UIViewController {
    
    let cellReuseID = "cellReuseID"
    
    var events : [Event] = []
    
    var pageNumber : Int = 0
    var totalRecords : Int = 0
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    let tableView : UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self

        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        title = "Fetch Events"
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        tableView.anchor(top: searchBar.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        tableView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            self?.resetSearch(loadData: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self?.tableView.cr.endHeaderRefresh()
                self?.tableView.cr.resetNoMore()
            })
        }
        
        tableView.cr.addFootRefresh(animator: NormalFooterAnimator()) { [weak self] in
            self?.loadData(params: [:])
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {

                self?.tableView.cr.endLoadingMore()
                
                let totalCount = self?.totalRecords ?? 0
                if self?.events.count == totalCount {
                    self?.tableView.cr.noticeNoMoreData()
                }
            })
        }
        
        let params : [String: Any] = [:]
        loadData(params: params)
    }

}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventTableViewCell
        
        let node = events[indexPath.row]
        
        cell.eventTitle.text = node.title
        
        let city = node.venue?.city ?? ""
        let state = node.venue?.state ?? ""
        cell.eventLocation.text = city + ", " + state
        
        cell.eventDate.text = convertUTC(timestamp: node.datetime_utc)
        
        let url = URL(string: node.performers![0].image!)
        
        DispatchQueue.main.async {
            cell.eventImage.kf.setImage(with: url)
        }
        
        cell.eventImage.setNeedsDisplay()

                
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EventsDetailViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension EventsViewController {
    @objc func loadData(params : [String: Any]) {
        
        let session = URLSession.shared
                
        pageNumber += 1
        let authentication = "client_id=" + clientId + "&" + "client_secret=" + secret
        let pageNumber = "page=" + String(pageNumber)
        let query = "q=" +  self.searchBar.text!
        
        let queryParams = authentication + "&" + pageNumber + "&" + query
        let url = URL(string: baseUrl + eventsEndpoint + "?" + queryParams)!
        

        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            do {
                
                let payload = try JSONDecoder().decode(EventModel.self, from: data!)
                let events = payload.events ?? []
                self.totalRecords = payload.meta!.total!
                
                self.events += events
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
    
    func resetSearch(loadData: Bool) {
        self.events = []
        self.pageNumber = 0
        self.totalRecords = 0
        if loadData {
            self.loadData(params: [:])
        }
    }
}

extension EventsViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
            }
        }
        
        searchBar.resignFirstResponder()
        
        
        resetSearch(loadData: false)
                
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(loadData(params:)), object: nil)
        self.perform(#selector(loadData(params:)), with: nil, afterDelay: 0.5)
    }
}
    

