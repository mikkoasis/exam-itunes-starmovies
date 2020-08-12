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

    highlightOverlay = UIView(frame: CGRect(origin: .zero, size: frame.size))
    highlightOverlay.backgroundColor = UIColor(named: "ButtonHighlightOverlayColor")
    highlightOverlay.isHidden = true
    self.addSubview(highlightOverlay)
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
