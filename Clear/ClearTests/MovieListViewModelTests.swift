//
//  MovieListViewModelTests.swift
//  ClearTests
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import RxCocoa
import RxSwift
import XCTest

@testable import Clear

class MovieListViewModelTests: XCTestCase {
  var disposeBag: DisposeBag!

  private func viewModel(limit: Int = 50) -> MovieListViewModel {
    let bundle = Bundle(for: type(of: self))

    guard let url = bundle.url(forResource: "TestMovies", withExtension: "json"),
      let data = try? Data(contentsOf: url) else {
      fatalError("\(#function) Failed to load TestUsers.json")
    }
    let apiService = MockiTunesAPIService(data: data, limit: limit)

    return MovieListViewModel(apiService: apiService)
  }

  private func fakeiTunesMovie() -> iTunesMovie {
    iTunesMovie(
      trackId: 1382545660,
      artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Video113/v4/80/fb/02/80fb0247-5d39-123f-b375-b85055577c29/pr_source.lsr/100x100bb.jpg",
      trackName: "Solo: A Star Wars Story",
      primaryGenreName: "Action & Adventure",
      longDescription: "Board the Millennium Falcon and journey",
      trackPrice: 18.00,
      currency: "AUD")
  }

  override func setUpWithError() throws {
    disposeBag = DisposeBag()
  }

  func test_reloadMovies() {
    // Given
    let viewModel = self.viewModel()
    var result = [iTunesMovie]()
    let expectation = self.expectation(description: #function)
    expectation.expectedFulfillmentCount = 2

    // When
    viewModel.movies.asDriver().drive(onNext: { movies in
      result = movies
      expectation.fulfill()
    })
      .disposed(by: disposeBag)
    viewModel.reloadMovies(with: "Star")

    // Then
    wait(for: [expectation], timeout: 2)
    XCTAssert(result.count > 0, "Expected movies to have items")
  }

  func test_reachedEndWhenFetchedIsLessThanLimit() {
    // Given
    let viewModel = self.viewModel(limit: 100)
    var result: MovieListViewModel.MovieListState = .initial
    let expectation = self.expectation(description: #function)
    expectation.expectedFulfillmentCount = 3

    // When
    viewModel.state.asDriver().drive(onNext: { state in
      result = state
      expectation.fulfill()
    })
      .disposed(by: disposeBag)
    viewModel.loadMoreMovies(with: "Star")

    // Then
    wait(for: [expectation], timeout: 2)
    XCTAssert(result == .reachedEnd, "Expected state to have reached end")
  }

  func test_loadMoreMovies() {
    // Given
    let viewModel = self.viewModel()
    var result = [iTunesMovie]()
    let expectation = self.expectation(description: #function)
    expectation.expectedFulfillmentCount = 2

    // When
    viewModel.movies.accept([self.fakeiTunesMovie()])
    viewModel.movies.asDriver().drive(onNext: { movies in
      result = movies
      expectation.fulfill()
    })
      .disposed(by: disposeBag)
    viewModel.loadMoreMovies(with: "Star")

    // Then
    wait(for: [expectation], timeout: 2)
    XCTAssert(result.count > 50, "Expected movies count to be more than default limit")
  }

  func test_getMovieCellWithValue() {
    // Given
    var result: MovieCellViewModel?
    let viewModel = self.viewModel()
    let expectation = self.expectation(description: #function)
    expectation.expectedFulfillmentCount = 2

    // When
    viewModel.movies.asDriver().drive(onNext: { _ in
      expectation.fulfill()
    })
      .disposed(by: disposeBag)
    viewModel.reloadMovies(with: "Star")
    wait(for: [expectation], timeout: 2)
    result = viewModel.cellViewModelForMovie(at: 0)

    // Then
    XCTAssert(result != nil, "Expected cellViewModel to be set")
  }

  func test_getMovieCellWithInvalidIndex() {
    // Given
    var result: MovieCellViewModel?
    let viewModel = self.viewModel()

    // When
    result = viewModel.cellViewModelForMovie(at: 0)

    // Then

    XCTAssert(result == nil, "Expected cellViewModel to be nil")
  }

  func test_getMovieDetailViewModelWithValue() {
    // Given
    var result: MovieDetailViewModel?
    let viewModel = self.viewModel()
    let expectation = self.expectation(description: #function)
    expectation.expectedFulfillmentCount = 2

    // When
    viewModel.movies.asDriver().drive(onNext: { _ in
      expectation.fulfill()
    })
      .disposed(by: disposeBag)
    viewModel.reloadMovies(with: "Star")
    wait(for: [expectation], timeout: 2)
    result = viewModel.movieDetailViewModelForMovie(at: 0)

    // Then
    XCTAssert(result != nil, "Expected movieDetailViewModel to be set")
  }

  func test_getMovieDetailViewModelWithInvalidIndex() {
    // Given
    var result: MovieDetailViewModel?
    let viewModel = self.viewModel()

    // When
    result = viewModel.movieDetailViewModelForMovie(at: 0)

    // Then

    XCTAssert(result == nil, "Expected movieDetailViewModel to be nil")
  }
}
