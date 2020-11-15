//
//  UIColor+Extension.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import UIKit

extension UIColor {
    convenience init(color: ThemeColor) {
        self.init(named: color.rawValue)!
    }
}
