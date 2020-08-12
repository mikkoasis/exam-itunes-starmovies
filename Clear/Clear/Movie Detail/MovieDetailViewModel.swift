//
//  MovieDetailViewModel.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/13/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class MovieDetailViewModel {
  private let movie: iTunesMovie
  let title = BehaviorRelay<String>(value: "")
  let imageURL = BehaviorRelay<URL?>(value: nil)
  let movieDescription = BehaviorRelay<String>(value: "")

  init(with movie: iTunesMovie) {
    self.movie = movie
    configure(with: self.movie)
  }

  private func configure(with movie: iTunesMovie) {
    title.accept(movie.trackName)
    movieDescription.accept(movie.longDescription)

    // Try to get a higher image resolution from the existing image URL string
    var imageURLString = movie.artworkUrl100
    imageURLString = imageURLString.replacingOccurrences(of: "100x100", with: "1000x1000")

    imageURL.accept(URL(string: imageURLString))
  }
}
