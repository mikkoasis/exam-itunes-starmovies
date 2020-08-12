//
//  MovieListViewModel.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class MovieListViewModel {
  private let apiService: iTunesAPIService

  var moviesCount: Int {
    self.movies.value.count
  }

  let movies = BehaviorRelay<[iTunesMovie]>(value: [])

  private let disposeBag = DisposeBag()

  init(apiService: iTunesAPIService = iTunesAPIService()) {
    self.apiService = apiService
  }

  func reloadMovies(with term: String) {
    loadMovies(with: term, offset: 0)
  }

  func loadMoreMovies(with term: String) {
    loadMovies(with: term, offset: movies.value.count)
  }

  private func loadMovies(with term: String, offset: Int) {
    apiService.searchMovies(search: term, offset: offset, completion: { [weak self] movies in
      guard let self = self else { return }
      if offset > 0 {
        self.movies.accept(self.movies.value + movies)
      } else {
        self.movies.accept(movies)
      }
    })
  }

  func cellViewModelForMovie(at index: Int) -> MovieCellViewModel? {
    if index >= self.movies.value.count {
      return nil
    }
    return MovieCellViewModel(with: self.movies.value[index])
  }
}
