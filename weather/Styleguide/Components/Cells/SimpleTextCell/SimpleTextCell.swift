//
//  SimpleTextCell.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import UIKit

class SimpleTextCell: UITableViewCell, IdentifierProtocol {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var bottomSpacing: NSLayoutConstraint!
    @IBOutlet weak var topSpacing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func updateCell(model: SimpleTextCellModel) {
        valueLabel.text = model.text
        valueLabel.skin(skin: model.textSkin)
        topSpacing.constant = CGFloat(model.topSpacing)
        bottomSpacing.constant = CGFloat(model.bottomSpacing)
    }
}
