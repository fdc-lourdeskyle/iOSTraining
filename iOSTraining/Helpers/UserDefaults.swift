//
//  UserDefaults.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/22/25.
//

import Foundation

extension UserDefaults{
    private var favoritesKey: String { "favoriteTeacherIDs" }

    func isFavorite(id: Int) -> Bool {
        let ids = favoriteTeacherIDs()
        return ids.contains(id)
    }

    func addFavorite(id: Int) {
        var ids = favoriteTeacherIDs()
        if !ids.contains(id) {
            ids.append(id)
            set(ids, forKey: favoritesKey)
        }
    }

    func removeFavorite(id: Int) {
        var ids = favoriteTeacherIDs()
        if let index = ids.firstIndex(of: id) {
            ids.remove(at: index)
            set(ids, forKey: favoritesKey)
        }
    }

    func favoriteTeacherIDs() -> [Int] {
        return array(forKey: favoritesKey) as? [Int] ?? []
    }
}
