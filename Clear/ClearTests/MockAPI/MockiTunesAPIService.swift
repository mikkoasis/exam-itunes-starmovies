//
//  MockiTunesAPIService.swift
//  ClearTests
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

@testable import Clear
import Foundation

struct MockiTunesAPIService: iTunesMoviesService {
  let data: Data
  let fetchLimit: Int
  static let decoder = JSONDecoder()

  init(data: Data, limit: Int = 50) {
    self.data = data
    self.fetchLimit = limit
  }

  func searchMovies(search: String, limit: Int, offset: Int, completion: @escaping ([iTunesMovie], Bool) -> Void) {
    do {
      let result = try Self.decoder.decode(itunesMoviesData.self, from: data)
      let movies = Array(result.results.prefix(limit))
      completion(movies, movies.count < self.fetchLimit)

    } catch {}
  }
}
