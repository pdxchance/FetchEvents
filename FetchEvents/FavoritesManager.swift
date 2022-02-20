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
    
    func getFavorites() -> [Favorite] {
        
        let defaults = UserDefaults.standard
        let keys = defaults.array(forKey: "Favorites")  as? [Int] ?? [Int]()
        
        var favs = [Favorite]()
        for key in keys {
            let fav = Favorite(id: key)
            favs.append(fav)
        }
        
        self.favorites = favs
        
        return favorites
    }
    
    func setFavorites() {
        
        let defaults = UserDefaults.standard
        
        var favs = [Int]()
        for key in favorites {
            let id = key.id
            favs.append(id)
        }
        
        defaults.set(favs, forKey: "Favorites")
    }
    
    func isFavorite(event : Event) -> Bool {
        self.favorites = getFavorites()
        if let index = favorites.firstIndex(where: { favorite in
            return favorite.id == event.id
        }) {
            return true
        } else {
            return false
        }
    }
    
    func removeFavorite(event : Event) {
        self.favorites = getFavorites()
        if let index = favorites.firstIndex(where: { favorite in
            return favorite.id == event.id
        }) {
            favorites.remove(at: index)
        } 
        

    }
    
    func addFavorite(favorite: Favorite) {
        favorites.append(favorite)
        setFavorites()
    }
}
