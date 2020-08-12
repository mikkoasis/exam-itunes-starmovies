//
//  MovieListViewController.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class MovieListViewController: UIViewController {
  private let searchTerm = "Star"

  private var viewModel: MovieListViewModel = MovieListViewModel()
  private let disposeBag = DisposeBag()

  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    title = searchTerm

    setupBindings()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if viewModel.moviesCount == 0 {
      viewModel.reloadMovies(with: searchTerm)
    }
  }

  private func setupBindings() {
    viewModel.movies.asDriver()
      .drive(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.tableView.reloadData()
      })
      .disposed(by: disposeBag)
  }
}

extension MovieListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.moviesCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: MovieTableViewCell

    if let dequeuedCell = tableView.dequeueReusableCell(
      withIdentifier: MovieTableViewCell.reuseIdentifier) as? MovieTableViewCell {
      cell = dequeuedCell
    } else {
      cell = MovieTableViewCell()
    }

    cell.viewModel = viewModel.cellViewModelForMovie(at: indexPath.row)

    return cell
  }
}

extension MovieListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
