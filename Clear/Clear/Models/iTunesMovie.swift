//
//  iTunesMovie.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Foundation

struct itunesMoviesData: Codable {
  let resultCount: Int
  let results: [iTunesMovie]
}

struct iTunesMovie: Codable {
  let trackId: Int
  let artworkUrl100: String
  let trackName: String
  let primaryGenreName: String
  let longDescription: String
  let trackPrice: Double
  let currency: String
}
