//
//  SimpleTextCellModel.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

struct SimpleTextCellModel: CellModel {
    let text: String
    let textSkin: LabelSkin
    let topSpacing: Double
    let bottomSpacing: Double
    
    init(text: String, labelSkin: LabelSkin = LabelSkin.bodyLight, topSpacing: Double = 8, bottomSpacing: Double = 8) {
        self.text = text
        self.textSkin = labelSkin
        self.topSpacing = topSpacing
        self.bottomSpacing = bottomSpacing
    }
}
