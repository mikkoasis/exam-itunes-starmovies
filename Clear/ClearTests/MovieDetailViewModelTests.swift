//
//  MovieDetailViewModelTests.swift
//  ClearTests
//
//  Created by Adrian Mikko Asis on 8/13/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import RxCocoa
import RxSwift
import XCTest

@testable import Clear

class MovieDetailViewModelTests: XCTestCase {
  var disposeBag: DisposeBag!

  private func viewModel() -> MovieDetailViewModel {
    return MovieDetailViewModel(with: fakeiTunesMovie())
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

  func test_titleIsInitiatedOnCreate() {
    // Given
    var result = ""
    let expectation = self.expectation(description: #function)

    // When
    let viewModel = self.viewModel()
    viewModel.title.asDriver()
      .drive(onNext: { title in
        result = title
        expectation.fulfill()
      })
      .disposed(by: disposeBag)

    // Then
    wait(for: [expectation], timeout: 2)
    XCTAssert(result.count > 0, "Expected title to have positive length")
  }

  func test_toggleFavouriteTwice() {
    // TODO: Should use a mocked UserDefaults

    // Given
    let viewModel = self.viewModel()
    var result = viewModel.isFavourite.value
    let expected = result
    let expectation = self.expectation(description: #function)
    expectation.expectedFulfillmentCount = 3

    // When
    viewModel.isFavourite.asDriver()
      .drive(onNext: { isFavourite in
        result = isFavourite
        expectation.fulfill()
      })
      .disposed(by: disposeBag)
    viewModel.toggleFavourite()
    viewModel.toggleFavourite()

    // Then
    wait(for: [expectation], timeout: 2)
    XCTAssert(result == expected, "Expected isFavourite to remain the same")
  }
}
