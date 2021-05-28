//
//  Constraints.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/27/21.
//

import UIKit

extension UIView {
    
    func anchor(top : NSLayoutYAxisAnchor?, bottom : NSLayoutYAxisAnchor?, leading : NSLayoutXAxisAnchor?, trailing : NSLayoutXAxisAnchor?, padding : UIEdgeInsets = .zero, size : CGSize? = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let width = size?.width {
            if width != 0 {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
        }
        
        if let height = size?.height {
            if height != 0 {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
    
    func centerX(center: NSLayoutXAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: center).isActive = true
    }
    
    func centerY(center: NSLayoutYAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: center).isActive = true
    }
    
    func centerXY(centerX: NSLayoutXAxisAnchor, centerY: NSLayoutYAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: centerX).isActive = true
        centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
    
    
}

