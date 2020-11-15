//
//  LabelSkin.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

class LabelSkin {
    let font: FontSize
    let color: ColorStyle
    
    init(font: FontSize, color: ColorStyle = .light) {
        self.font = font
        self.color = color
    }
    
    enum FontSize {
        case heading1
        case heading2
        case bodyBold
        case body
        case caption
    }
    
    enum ColorStyle {
        case light
        case gray
        case dark
        case purple
        case red
        case blue
    }
}

extension LabelSkin {
    static var bodyLight = LabelSkin(font: .body, color: .light)
    static var bodyGray = LabelSkin(font: .body, color: .gray)
    static var bodyBoldLight = LabelSkin(font: .bodyBold, color: .light)
    static var heading1Ligt = LabelSkin(font: .heading1, color: .light)
    static var heading2Light = LabelSkin(font: .heading2, color: .light)
}
