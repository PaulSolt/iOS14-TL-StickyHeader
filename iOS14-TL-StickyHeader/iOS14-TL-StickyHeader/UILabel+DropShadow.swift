//
//  UILabel+DropShadow.swift
//  iOS14-TL-StickyHeader
//
//  Created by Paul Solt on 4/17/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

extension UILabel {
    var hasDropShadow: Bool {
        get {
            return self.layer.shadowOpacity != 0.0
        }
        set {
            if newValue {
                self.layer.shadowOffset = CGSize(width: 1, height: 1)
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 2.0
                self.layer.shadowOpacity = 0.2
            } else {
                self.layer.shadowOpacity = 0.0
            }
        }
    }
}
