//
//  EventTableViewCell.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    let imageStackView : UIStackView = {
       let imageStackView = UIStackView()
        imageStackView.axis = .vertical
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageStackView
    }()
    
    let eventImage : UIImageView = {
       let eventImage = UIImageView()
        eventImage.contentMode = .scaleAspectFit
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        
        return eventImage
    }()
    
    let bodyStackView : UIStackView = {
       let bodyStackView = UIStackView()
        bodyStackView.axis = .vertical
        bodyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return bodyStackView
    }()
    
    let eventTitle : UILabel = {
        let eventTitle = UILabel()
        eventTitle.font = .systemFont(ofSize: 24.0, weight: .black)
        eventTitle.numberOfLines = 0
        eventTitle.lineBreakMode = .byWordWrapping
        eventTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return eventTitle
    }()
    
    let eventLocation : UILabel = {
        let eventLocation = UILabel()
        eventLocation.translatesAutoresizingMaskIntoConstraints = false
        
        return eventLocation
    }()
    
    let eventDate : UILabel = {
        let eventDate = UILabel()
        eventDate.translatesAutoresizingMaskIntoConstraints = false
        
        return eventDate
    }()
    
    let eventTime : UILabel = {
        let eventTime = UILabel()
        eventTime.translatesAutoresizingMaskIntoConstraints = false
        
        return eventTime
    }()
    
//    eventFavoriteImage

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(eventImage)
        contentView.addSubview(bodyStackView)
        
        
        bodyStackView.addArrangedSubview(eventTitle)
        bodyStackView.addArrangedSubview(eventLocation)
        bodyStackView.addArrangedSubview(eventDate)
        bodyStackView.addArrangedSubview(eventTime)
        
        eventImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: nil, padding: .init(top: 16, left: 0, bottom: 16, right: 0), size: .init(width: 200, height: 100))
        
        bodyStackView.anchor(top: eventImage.topAnchor, bottom: contentView.bottomAnchor, leading: eventImage.trailingAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 16, right: 8))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
