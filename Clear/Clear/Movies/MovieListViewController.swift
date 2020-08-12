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
  @IBOutlet var footerView: MovieListFooterView!

  override func viewDidLoad() {
    super.viewDidLoad()

    title = searchTerm

    setupTableViewRefresh()
    setupBindings()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if viewModel.moviesCount == 0 {
      reloadMovies()
    }
  }

  private func setupTableViewRefresh() {
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.addTarget(
      self,
      action: #selector(handleRefreshControl),
      for: .valueChanged)
  }

  private func setupBindings() {
    viewModel.movies.asDriver()
      .drive(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.tableView.reloadData()
      })
      .disposed(by: disposeBag)

    viewModel.state.asDriver()
      .drive(onNext: { [weak self] state in
        guard let self = self else { return }
        switch state {
          case .fetching:
            self.footerView.activityIndicatorView.startAnimating()
          case .initial, .idle:
            self.tableView.refreshControl?.endRefreshing()
          case .reachedEnd:
            self.footerView.activityIndicatorView.stopAnimating()
            self.tableView.refreshControl?.endRefreshing()
        }
      })
      .disposed(by: disposeBag)
  }

  private func reloadMovies() {
    viewModel.reloadMovies(with: searchTerm)
  }

  private func loadMoreMovies() {
    viewModel.loadMoreMovies(with: searchTerm)
  }

  @objc private func handleRefreshControl() {
    reloadMovies()
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

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.moviesCount - 1 {
      loadMoreMovies()
    }
  }
}
