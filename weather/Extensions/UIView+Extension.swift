//
//  UIView+Extension.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import UIKit

extension UIView {
    func addTopBorderWithColor(color: UIColor, boredWidth: CGFloat = 1 / UIScreen.main.scale) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: boredWidth)
        self.layer.addSublayer(border)
    }
}
