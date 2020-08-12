//
//  UIView+Extensions.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }

    set {
      layer.cornerRadius = newValue
      clipsToBounds = layer.cornerRadius > 0
    }
  }
}
