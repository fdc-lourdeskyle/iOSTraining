//
//  UserDefaults.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/22/25.
//

import Foundation

extension UserDefaults{
    private static let favoriteKey = "FavoriteTeacherIDs"

    var favoriteTeacherIDs: [Int] {
        get {
            return array(forKey: Self.favoriteKey) as? [Int] ?? []
        }
        set {
            set(newValue, forKey: Self.favoriteKey)
        }
    }

    func isFavorite(id: Int) -> Bool {
        favoriteTeacherIDs.contains(id)
    }

    func toggleFavorite(id: Int) {
        var current = favoriteTeacherIDs
        if let index = current.firstIndex(of: id){
            current.remove(at: index)
        } else {
            current.append(id)
        }
        favoriteTeacherIDs = current
    }

}
