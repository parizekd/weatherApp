//
//  ForecastTableCell.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import UIKit

class ForecastTableCell: UITableViewCell, IdentifierProtocol {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        dayLabel.skin(skin: LabelSkin.bodyLight)
        tempLabel.skin(skin: LabelSkin.bodyLight)
        humidityLabel.skin(skin: LabelSkin(font: .body, color: .blue))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
    func updateCell(model: ForecastTableCellModel) {
        dayLabel.text = model.day.capitalizingFirstLetter()
        humidityLabel.text = model.humidity
        tempLabel.text = model.temp
        if let url = URL(string: model.iconUrl) {
            weatherImage.load(url: url)
        }
    }
}
