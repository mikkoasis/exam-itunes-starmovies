//
//  AddFavouriteButton.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/13/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import UIKit

class AddFavouriteButton: UIButton {
  private enum State: Int {
    case addFavourite = 0
    case removeFavourite
  }

  private var highlightOverlay: UIView!

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    addHighlightOverlay()
  }

  private func addHighlightOverlay() {
    highlightOverlay = UIView()
    highlightOverlay.backgroundColor = UIColor(named: "ButtonHighlightOverlayColor")
    highlightOverlay.isHidden = true
    addSubview(highlightOverlay)

    highlightOverlay.translatesAutoresizingMaskIntoConstraints = false

    let leadingConstraint = NSLayoutConstraint(
      item: highlightOverlay as Any,
      attribute: .leading,
      relatedBy: .equal,
      toItem: self,
      attribute: .leading,
      multiplier: 1,
      constant: 0)

    let trailingConstraint = NSLayoutConstraint(
      item: highlightOverlay as Any,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: self,
      attribute: .trailing,
      multiplier: 1,
      constant: 0)

    let topConstraint = NSLayoutConstraint(
      item: highlightOverlay as Any,
      attribute: .top,
      relatedBy: .equal,
      toItem: self,
      attribute: .top,
      multiplier: 1,
      constant: 0)

    let bottomConstraint = NSLayoutConstraint(
      item: highlightOverlay as Any,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: self,
      attribute: .bottom,
      multiplier: 1,
      constant: 0)

    addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    tag = State.addFavourite.rawValue
  }

  override var isHighlighted: Bool {
    didSet {
      highlightOverlay.isHidden = !isHighlighted
    }
  }

  override var tag: Int {
    didSet {
      if tag == State.removeFavourite.rawValue {
        backgroundColor = UIColor(named: "ButtonRedColor")
        setTitle("Remove to favourites", for: .normal)
      } else {
        backgroundColor = UIColor(named: "ButtonGreenColor")
        setTitle("Add to favourites", for: .normal)
      }
    }
  }
}
