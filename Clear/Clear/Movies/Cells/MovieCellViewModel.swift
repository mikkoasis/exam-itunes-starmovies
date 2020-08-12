//
//  MovieCellViewModel.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Foundation

final class MovieCellViewModel {
  private let movie: iTunesMovie
  private(set) var title = ""
  private(set) var genre = ""
  private(set) var price = ""
  private(set) var imageURL: URL?
  private(set) var isFavourite = false

  private static let numberFormatter = NumberFormatter()

  init(with movie: iTunesMovie) {
    Self.numberFormatter.numberStyle = .currency

    self.movie = movie
    configure(with: self.movie)
  }

  private func configure(with movie: iTunesMovie) {
    title = movie.trackName
    genre = movie.primaryGenreName

    Self.numberFormatter.currencyCode = movie.currency
    price = "\(Self.numberFormatter.string(for: movie.trackPrice)!)"

    if let url = URL(string: movie.artworkUrl100) {
      imageURL = url
    } else {
      imageURL = nil
    }

    isFavourite = FavouriteMoviesHelper.isFavourite(movieId: movie.trackId)
  }
}
