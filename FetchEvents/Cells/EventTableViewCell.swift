//
//  EventTableViewCell.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    let contentStackView : UIStackView = {
       let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentStackView
    }()
    
    let imageStackView : UIStackView = {
       let imageStackView = UIStackView()
        imageStackView.axis = .vertical
        imageStackView.distribution = .fill
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageStackView
    }()
    
    let eventImage : UIImageView = {
       let eventImage = UIImageView()
        eventImage.contentMode = .scaleToFill
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
        eventDate.font = .systemFont(ofSize: 17.0, weight: .thin)
        eventDate.translatesAutoresizingMaskIntoConstraints = false
        
        return eventDate
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imageStackView)
        addSubview(bodyStackView)
        addSubview(contentStackView)
        
        imageStackView.addArrangedSubview(eventImage)
        
        bodyStackView.addArrangedSubview(eventTitle)
        bodyStackView.addArrangedSubview(eventLocation)
        bodyStackView.addArrangedSubview(eventDate)
        
        contentStackView.addArrangedSubview(imageStackView)
        contentStackView.addArrangedSubview(bodyStackView)
        
        contentStackView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
