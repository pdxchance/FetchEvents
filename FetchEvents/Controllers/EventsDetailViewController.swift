//
//  EventsDetailViewController.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

class EventsDetailViewController: UIViewController {
    
    var event : Event?
    
    var delegate : UpdateFavoritesProtocol?
    
    var isSelected: Bool?

    
    let favoriteImage : UIButton = {
       let favoriteImage = UIButton()
        favoriteImage.contentMode = .scaleAspectFit
        favoriteImage.setImage(UIImage(named: "icons8-like"), for: .selected)
        favoriteImage.setImage(UIImage(named: "icons8-hearts"), for: .normal)
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false

        return favoriteImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = .white
        
        favoriteImage.addTarget(self, action: #selector(toggleFavorites), for: .touchUpInside)
        favoriteImage.isSelected = isSelected ?? false
        
        let eventDetailView = EventDetailView(frame: CGRect.zero)
        view.addSubview(eventDetailView)
        
        eventDetailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        let viewModel = EventViewModel(event: event!)
        
        eventDetailView.eventTitle.text = viewModel.eventTitle
        eventDetailView.eventLocation.text = viewModel.eventLocation
        eventDetailView.eventDate.text = viewModel.eventDateTime
        
        let url = URL(string: (event?.performers![0].image!)!)
        eventDetailView.eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), completionHandler: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate!.updateFavorites(event: event!, isSelected: favoriteImage.isSelected)
        
    }
    
    @objc func toggleFavorites() {
        favoriteImage.isSelected = !favoriteImage.isSelected
    }
}
