//
//  iTunesMoviesService.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Foundation

protocol iTunesMoviesService {
  func searchMovies(
    search: String,
    limit: Int,
    offset: Int,
    completion: @escaping ([iTunesMovie], Bool) -> Void)
}
