//
//  EventsDetailViewController.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

class EventsDetailViewController: UIViewController, ButtonTappedProtocol {
    
    var event : CompactEvent
    
    weak var delegate : RefreshProtocol?
    
    var favoritesManager : FavoritesManager
    
    let eventDetailView = EventDetailView(frame: CGRect.zero)
    
    
    init(event: CompactEvent, delegate: RefreshProtocol, favoritesManager: FavoritesManager) {
        self.event = event
        self.delegate = delegate
        self.favoritesManager = favoritesManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureBackButton()
        
        configureView()
        
        loadEvent()
        
        setFavorite()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let image = event.image {
            let url = URL(string: image)
            eventDetailView.eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), completionHandler: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.refresh()
    }
    
    func favoriteButtonTapped(isSelected: Bool) {
        
        if let id = event.id {
            
            let favorite = Favorite(id: id)
            if isSelected {
                favoritesManager.addFavorite(favorite: favorite)
            } else {
                favoritesManager.removeFavorite(event: event)
            }
        }
    }
    
    fileprivate func configureBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    fileprivate func configureView() {
        eventDetailView.delegate = self
        view.addSubview(eventDetailView)
        eventDetailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    fileprivate func loadEvent() {
        let viewModel = EventViewModel(event: event)
        eventDetailView.eventTitle.text = viewModel.eventTitle
        eventDetailView.eventLocation.text = viewModel.eventLocation
        eventDetailView.eventDate.text = viewModel.eventDateTime
    }
    
    fileprivate func setFavorite() {
        eventDetailView.favoriteImage.isSelected = favoritesManager.isFavorite(event: event)
    }
}
