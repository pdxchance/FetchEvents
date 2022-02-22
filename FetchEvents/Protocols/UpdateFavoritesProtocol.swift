//
//  UpdateFavoritesProtocol.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/28/21.
//

import Foundation

protocol UpdateFavoritesProtocol : NSObjectProtocol {
    func updateFavorites(isSelected: Bool)
}

protocol RefreshProtocol : NSObjectProtocol {
    func refresh()
}
