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
    
    let favoritesManager = FavoritesManager()
    
    let cellReuseID = "cellReuseID"
    
    var viewModels : [EventViewModel] = []
        
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
            self?.loadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {

                guard let self = self else { return }
                
                self.tableView.cr.endLoadingMore()
                
                let totalCount = self.apiManager.getTotalRecords()
                if self.viewModels.count == totalCount {
                    self.tableView.cr.noticeNoMoreData()
                }
            })
        }
        

    }

}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiManager.getArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventTableViewCell
        
        let event = apiManager.getEvent(index: indexPath.row)
        
        let vm = EventViewModel(event: event!)
        cell.eventTitle.text = vm.eventTitle
        cell.eventLocation.text = vm.eventLocation
        cell.eventDate.text = vm.eventDateTime
        
        let url = URL(string: (event?.performers![0].image!)!)
        cell.eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), completionHandler: nil)
        
        cell.favoriteImage.isHidden = favoritesManager.isFavorite(event: event!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vm = viewModels[indexPath.row]
        let isFavorite = favoritesManager.isFavorite(event: vm.event)

        let controller = EventsDetailViewController()
        controller.event = vm.event
        controller.delegate = self
        controller.isSelected = isFavorite
        
        show(controller, sender: self)
    }
}

extension EventsViewController {
    @objc func loadData() {
        
        guard let searchTerm = searchBar.text else {
            return
        }
        
        apiManager.queryEvents(query: searchTerm, completion: { events in
            DispatchQueue.main.async {
                self.viewModels = events.map({ event in
                    return EventViewModel(event: event)
                })
                self.tableView.reloadData()
            }
        })
    }
    
    func resetSearch(loadData: Bool) {
        apiManager.clearEvents()
        if loadData {
            self.loadData()
        }
        tableView.reloadData()
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
                
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(loadData), object: nil)
        self.perform(#selector(loadData), with: nil, afterDelay: 0.5)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension EventsViewController: UpdateFavoritesProtocol {
    func updateFavorites(event: Event, isSelected: Bool) {
        
        guard event.id != nil else { return }
        
        let isSelected = favoritesManager.isFavorite(event: event)
        
        if !isSelected {
            favoritesManager.removeFavorite(event: event)
        } else {
            let favorite = Favorite(id: event.id!)
            favoritesManager.addFavorite(favorite: favorite)
        }
                
        favoritesManager.setFavorites()
        tableView.reloadData()
    }
}
    

