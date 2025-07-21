//
//  FavoriteManager.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/16/25.
//

import Foundation

class FavoriteManager: ObservableObject {

    static let shared = FavoriteManager()

    @Published var favoriteProductIds: Set<Int> = []

    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favorite_products"

    private init() {
        loadFavorites()
    }

    func addFavorite(_ product: Product) {
        favoriteProductIds.insert(product.id)
        saveFavorites()
    }

    func removeFavorite(_ product: Product) {
        favoriteProductIds.remove(product.id)
        saveFavorites()
    }

    func isFavorite(_ product: Product) -> Bool {
        return favoriteProductIds.contains(product.id)
    }

    private func saveFavorites() {
        let favoriteArray = Array(favoriteProductIds)
        userDefaults.set(favoriteArray, forKey: favoritesKey)
    }

    private func loadFavorites() {
        if let savedFavorites = userDefaults.array(forKey: favoritesKey) as? [Int] {
            favoriteProductIds = Set(savedFavorites)
        }
    }

}
