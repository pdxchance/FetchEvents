//
//  EventTableViewCell.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    let eventImage : UIImageView = {
       let eventImage = UIImageView()
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
        bodyStackView.addSubview(eventTime)
        
        eventImage.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        
        bodyStackView.anchor(top: contentView.topAnchor, bottom: nil, leading: eventImage.leadingAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
