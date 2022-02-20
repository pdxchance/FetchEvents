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
    
    let apiManager = EventsApiManager.shared
    
    let cellReuseID = "cellReuseID"
    
    var events : [Event] = []
    
    var favorites : [Int] = []
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search events"
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
        
        let defaults = UserDefaults.standard
        self.favorites = defaults.array(forKey: "Favorites")  as? [Int] ?? [Int]()
        
        view.backgroundColor = .white
        
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self

        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        title = "Fetch Events"
        
        searchBar.returnKeyType = .done
        
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

                guard let self = self else { return }
                
                self.tableView.cr.endLoadingMore()
                
                let totalCount = self.apiManager.getTotalRecords()
                if self.events.count == totalCount {
                    self.tableView.cr.noticeNoMoreData()
                }
            })
        }
        

    }

}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiManager.getTotalRecords()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventTableViewCell
        
        let node = apiManager.getEvent(index: indexPath.row)
        let viewModel = EventViewModel(event: node)
        
        cell.eventTitle.text = viewModel.eventTitle
        cell.eventLocation.text = viewModel.eventLocation
        cell.eventDate.text = viewModel.eventDateTime
        
        let url = URL(string: node.performers![0].image!)
        cell.eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), completionHandler: nil)
        
        if let index = favorites.firstIndex(where: { $0 == node.id }) {
            cell.favoriteImage.isHidden = false
        } else {
            cell.favoriteImage.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        
        var isSelected = false
        if let index = favorites.firstIndex(where: { $0 == event.id }) {
            isSelected = true
        }

        let controller = EventsDetailViewController()
        controller.event = event
        controller.delegate = self
        controller.isSelected = isSelected
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension EventsViewController {
    @objc func loadData(params : [String: Any]) {
        
        guard let searchTerm = searchBar.text else {
            return
        }
        
        apiManager.getEvents(query: searchTerm, completion: { events, total in
            DispatchQueue.main.async {
                self.events = events
                self.tableView.reloadData()
            }
        })
    }
    
    func resetSearch(loadData: Bool) {
        apiManager.clearEvents()
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
        
        resetSearch(loadData: false)
                
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(loadData(params:)), object: nil)
        self.perform(#selector(loadData(params:)), with: nil, afterDelay: 0.5)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension EventsViewController: UpdateFavoritesProtocol {
    func updateFavorites(event: Event, isSelected: Bool) {
        
        let eventId = event.id ?? 0
        if let index = favorites.firstIndex(where: { $0 == eventId }) {
            if !isSelected {
                favorites.remove(at: index)
            }
        } else {
            if isSelected {
                favorites.append(eventId)
            }
        }
                
        let defaults = UserDefaults.standard
        defaults.set(self.favorites, forKey: "Favorites")
        
        tableView.reloadData()
    }
}
    

