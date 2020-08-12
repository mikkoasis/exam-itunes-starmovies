//
//  iTunesAPIService.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Alamofire
import Foundation

final class iTunesAPIService {}

extension iTunesAPIService: iTunesMoviesService {
  func searchMovies(
    search: String,
    limit: Int = 50,
    offset: Int = 0,
    completion: @escaping ([iTunesMovie], Bool) -> Void) {
    AF.request(iTunesAPIRouter.searchMovies(term: search, limit: limit, offset: offset))
      .validate()
      .responseDecodable(of: itunesMoviesData.self) { response in
        switch response.result {
        case .success(let iTunesData):
          let results = iTunesData.results
          let reachedEnd = results.count < limit
          completion(results, reachedEnd)
        case .failure(let error):
          print("\(error.localizedDescription)")
          completion([iTunesMovie](), true)
        }
      }
  }
}
