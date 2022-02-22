//
//  EventsDetailViewController.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

class EventsDetailViewController: UIViewController, UpdateFavoritesProtocol {

    var event : CompactEvent?
    
    weak var delegate : RefreshProtocol?
    
    var favoritesManager : FavoritesManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = .white
        
        let eventDetailView = EventDetailView(frame: CGRect.zero)
        eventDetailView.delegate = self
        view.addSubview(eventDetailView)
        
        eventDetailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        let viewModel = EventViewModel(event: event!)
        
        eventDetailView.eventTitle.text = viewModel.eventTitle
        eventDetailView.eventLocation.text = viewModel.eventLocation
        eventDetailView.eventDate.text = viewModel.eventDateTime
        
        if let favoritesManager = favoritesManager {
            eventDetailView.favoriteImage.isSelected = favoritesManager.isFavorite(event: event!)
        }
        
        if let image = event?.image {
            let url = URL(string: image)
            eventDetailView.eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), completionHandler: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.refresh()
    }
    
    func updateFavorites(isSelected: Bool) {
        
        let favorite = Favorite(id: (event?.id)!)
        if isSelected {
            favoritesManager?.addFavorite(favorite: favorite)
        } else {
            favoritesManager?.removeFavorite(event: self.event!)
        }
    }
}
