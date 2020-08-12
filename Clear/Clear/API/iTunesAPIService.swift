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
  func getMovies(
    search: String,
    limit: Int = 50,
    offset: Int = 0,
    completion: @escaping ([iTunesMovie]) -> Void) {
    AF.request(iTunesAPIRouter.movie(term: search, limit: limit, offset: offset))
      .validate()
      .responseDecodable(of: itunesMoviesData.self) { response in
        switch response.result {
        case .success(let iTunesData):
          completion(iTunesData.results)
        case .failure(let error):
          print("\(error.localizedDescription)")
          completion([iTunesMovie]())
        }
      }
  }
}