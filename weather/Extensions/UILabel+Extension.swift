//
//  UILabel+Extension.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import UIKit

extension UILabel {
    
    func skin(skin: LabelSkin) {
        switch skin.font {
        case .heading1:
            self.font = UIFont.systemFont(ofSize: 64, weight: .black)
        case .heading2:
            self.font = UIFont.systemFont(ofSize: 32)
        case .bodyBold:
            self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        case .body:
            self.font = UIFont.systemFont(ofSize: 16)
        case .caption:
            self.font = UIFont.systemFont(ofSize: 14)
        }
        
        switch skin.color {
        case .light:
            self.textColor = UIColor(color: .white)
        case .dark:
            self.textColor = UIColor(color: .black)
        case .gray:
            self.textColor = UIColor(color: .gray)
        case .red:
            self.textColor = UIColor(color: .red)
        case .purple:
            self.textColor = UIColor(color: .purple)
        case .blue:
            self.textColor = UIColor(color: .blue)
        }
    }
}
