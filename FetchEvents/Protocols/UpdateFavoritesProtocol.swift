//
//  UpdateFavoritesProtocol.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/28/21.
//

import Foundation

protocol ButtonTappedProtocol : NSObjectProtocol {
    func favoriteButtonTapped(isSelected: Bool)
}

protocol RefreshProtocol : NSObjectProtocol {
    func refresh()
}
