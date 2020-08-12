//
//  MovieDetailViewController.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/13/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import AlamofireImage
import RxCocoa
import RxSwift
import UIKit

class MovieDetailViewController: UIViewController {
  var viewModel: MovieDetailViewModel!
  var disposeBag = DisposeBag()

  @IBOutlet private var favouriteButton: AddFavouriteButton!
  @IBOutlet private var detailView: MovieDetailView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavigationBar()
    setupBindings()
  }

  private func setupNavigationBar() {
    let doneButton = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(doneTapped))

    navigationItem.rightBarButtonItem = doneButton
  }

  func setupBindings() {
    viewModel.title.asDriver()
      .drive(onNext: { [weak self] title in
        guard let self = self else { return }
        self.title = title
      })
      .disposed(by: disposeBag)

    viewModel.imageURL.asDriver()
      .drive(onNext: { [weak self] url in
        guard let self = self else { return }

        guard let url = url else {
          self.detailView.imageView.image = nil
          return
        }
        self.detailView.imageView.af.setImage(withURL: url)
      })
      .disposed(by: disposeBag)

    viewModel.movieDescription.asDriver()
      .drive(onNext: { [weak self] descriptionString in
        guard let self = self else { return }
        self.detailView.descriptionLabel.text = descriptionString
      })
      .disposed(by: disposeBag)
  }

  private func dismiss() {
    dismiss(animated: true)
  }

  @objc func doneTapped() {
    dismiss()
  }

  @IBAction func favouriteTapped() {
    favouriteButton.tag = favouriteButton.tag == 0 ? 1 : 0
  }
}
