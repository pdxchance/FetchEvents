//
//  EventDetailView.swift
//  FetchEvents
//
//  Created by Deanne Chance on 2/19/22.
//

import UIKit

class EventDetailView: UIView {
    
    weak var delegate : ButtonTappedProtocol?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(eventTitle)
        contentStackView.addArrangedSubview(eventImage)
        contentStackView.addArrangedSubview(eventLocation)
        contentStackView.addArrangedSubview(eventDate)
        addSubview(favoriteImage)
        
        favoriteImage.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        contentStackView.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor)
        
        favoriteImage.anchor(top: eventImage.topAnchor, bottom: nil, leading: nil, trailing: eventImage.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return favoriteImage
    }
    
    @objc private func favoriteButtonTapped() {
            
        guard delegate != nil else { return }
        
        favoriteImage.isSelected = !favoriteImage.isSelected

        delegate?.favoriteButtonTapped(isSelected: favoriteImage.isSelected)
    }
    
}
