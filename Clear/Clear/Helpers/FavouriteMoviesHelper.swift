//
//  FavouriteMoviesHelper.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/13/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Foundation

class FavouriteMoviesHelper {
  enum Constants {
    enum NotificationName {
      static let didUpdate = Notification.Name("FavouritesDidUpdate")
    }

    enum UserDefaultsKey {
      static let favourites = "FavouritesKey"
    }
  }

  private var favourites: Set<Int> = []
  static let shared = FavouriteMoviesHelper()

  private init() {
    loadFavourites()
  }

  private func loadFavourites() {
    let favouritesArray = UserDefaults.standard.array(forKey: Constants.UserDefaultsKey.favourites)
      as? [Int] ?? []

    favourites = Set(favouritesArray)
  }

  private class func persistFavourites() {
    UserDefaults.standard.set(
      Array(Self.shared.favourites),
      forKey: Constants.UserDefaultsKey.favourites)

    NotificationCenter.default.post(name: Constants.NotificationName.didUpdate, object: nil)
  }
}

extension FavouriteMoviesHelper {
  class func addFavourite(movieId: Int) {
    Self.shared.favourites.insert(movieId)
    persistFavourites()
  }

  class func removeFavourite(movieId: Int) {
    Self.shared.favourites.remove(movieId)
    persistFavourites()
  }

  class func isFavourite(movieId: Int) -> Bool {
    Self.shared.favourites.contains(movieId)
  }
}
