//
//  EventsDetailViewController.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

class EventsDetailViewController: UIViewController {
    
    var event : Event
    
    let contentStackView : UIStackView = {
       let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentStackView
    }()
    
    let eventTitle : UILabel = {
        let eventTitle = UILabel()
        eventTitle.font = .systemFont(ofSize: 24.0, weight: .black)
        eventTitle.numberOfLines = 0
        eventTitle.lineBreakMode = .byWordWrapping
        eventTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return eventTitle
    }()
    
    let eventImage : UIImageView = {
       let eventImage = UIImageView()
        eventImage.contentMode = .scaleToFill
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        
        return eventImage
    }()
    
    let eventLocation : UILabel = {
        let eventLocation = UILabel()
        eventLocation.translatesAutoresizingMaskIntoConstraints = false
        
        return eventLocation
    }()
    
    let eventDate : UILabel = {
        let eventDate = UILabel()
        eventDate.font = .systemFont(ofSize: 17.0, weight: .thin)
        eventDate.translatesAutoresizingMaskIntoConstraints = false
        
        return eventDate
    }()
    
    let favoriteImage : UIButton = {
       let favoriteImage = UIButton()
        favoriteImage.contentMode = .scaleAspectFit
        favoriteImage.setImage(UIImage(named: "icons8-like"), for: .selected)
        favoriteImage.setImage(UIImage(named: "icons8-hearts"), for: .normal)
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false

        return favoriteImage
    }()
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        favoriteImage.addTarget(self, action: #selector(toggleFavorites), for: .touchUpInside)

        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(eventTitle)
        contentStackView.addArrangedSubview(eventImage)
        contentStackView.addArrangedSubview(eventLocation)
        contentStackView.addArrangedSubview(eventDate)
        view.addSubview(favoriteImage)
        
        let viewModel = EventViewModel(event: event)
        
        eventTitle.text = viewModel.eventTitle
        eventLocation.text = viewModel.eventLocation
        eventDate.text = viewModel.eventDateTime
        
        let url = URL(string: event.performers![0].image!)
        DispatchQueue.main.async {
            self.eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), completionHandler: nil)
        }
        
        contentStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        favoriteImage.anchor(top: eventImage.topAnchor, bottom: nil, leading: nil, trailing: eventImage.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 50))
    }
    
    @objc func toggleFavorites() {
        favoriteImage.isSelected = !favoriteImage.isSelected
    }
}
