//
//  SimpleButtonCell.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import UIKit

class SimpleButtonCell: UITableViewCell, IdentifierProtocol {
    
    @IBOutlet private weak var actionButton: UIButton!
    
    var action: VoidCallback?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func updateCell(model: SimpleButtonCellModel) {
        actionButton.setTitle(model.buttonTitle, for: .normal)
        actionButton.setTitleColor(UIColor(color: model.titleColor), for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        action?()
    }
}
