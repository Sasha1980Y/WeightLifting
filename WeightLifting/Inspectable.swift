//
//  Inspectable.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 3/11/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}
