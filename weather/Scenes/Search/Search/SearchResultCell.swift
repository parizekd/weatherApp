//
//  SearchResultCell.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import UIKit

class SearchResultCell: UITableViewCell, IdentifierProtocol {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cityLabel.skin(skin: LabelSkin.bodyLight)
        countryLabel.skin(skin: LabelSkin.bodyLight)
    }
    
    func updateCell(model: SearchResultCellModel) {
        cityLabel.text = model.city
        countryLabel.text = model.country
    }

}
