//
//  UpdateFavoritesProtocol.swift
//  FetchEvents
//
//  Created by Deanne Chance on 5/28/21.
//

import Foundation

protocol UpdateFavoritesProtocol {
    func updateFavorites(event: Event, isSelected: Bool)
}
