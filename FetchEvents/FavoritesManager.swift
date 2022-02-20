//
//  FavoritesManager.swift
//  FetchEvents
//
//  Created by Deanne Chance on 2/19/22.
//

import Foundation

struct Favorite {
    let id : Int
}

class FavoritesManager {
    
    var favorites = [Favorite]()
    
    init() {
        self.favorites = getFavorites()
    }
    
    func getFavorites() -> [Favorite] {
        
        let defaults = UserDefaults.standard
        let keys = defaults.array(forKey: "Favorites")  as? [Int] ?? [Int]()
        
        self.favorites = keys.map({ id in
            let favorite = Favorite(id: id)
            return favorite
        })
        
        return favorites
    }
    
    func setFavorites() {
        
        let defaults = UserDefaults.standard
        let favorites = self.favorites.map { favorite in
            return favorite.id
        }
        
        defaults.set(favorites, forKey: "Favorites")
    }
    
    func clearFavorites() {
        
        favorites = []
        
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "Favorites")
    }
    
    func isFavorite(event : Event) -> Bool {

        let index = favorites.firstIndex(where: { fav in
            fav.id == event.id
        })
        
        return index != nil
    }
    
    func removeFavorite(event : Event) {

        let index = favorites.firstIndex(where: { favorite in
            return favorite.id == event.id
        })
        
        guard index != nil else { return }
        
        favorites.remove(at: index!)
        setFavorites()
    }
    
    func addFavorite(favorite: Favorite) {
        
        let index = favorites.firstIndex { fav in
            fav.id == favorite.id
        }
        
        // we already have this favorite
        guard index == nil else { return }
        
        favorites.append(favorite)
        setFavorites()
    }
}
