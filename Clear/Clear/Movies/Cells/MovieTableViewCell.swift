//
//  MovieTableViewCell.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class MovieTableViewCell: UITableViewCell {
  static let reuseIdentifier = "MovieTableViewCell"

  var viewModel: MovieCellViewModel? {
    didSet {
      configure()
    }
  }

  @IBOutlet var movieImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var genreLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func configure() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.title
    genreLabel.text = viewModel.genre
    priceLabel.text = viewModel.price

    if let imageURL = viewModel.imageURL {
      movieImageView.af.setImage(withURL: imageURL)
    } else {
      movieImageView.image = nil
    }
  }
}
