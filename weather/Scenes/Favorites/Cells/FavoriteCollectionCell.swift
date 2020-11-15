//
//  FavoriteCollectionCell.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import UIKit
import MapKit

class FavoriteCollectionCell: UICollectionViewCell, IdentifierProtocol {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var wrapperView: UIView!
    
    static let cellHeight = 220
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityLabel.skin(skin: LabelSkin.bodyBoldLight)
        countryLabel.skin(skin: LabelSkin.bodyLight)
        mapView.isUserInteractionEnabled = false
        wrapperView.layer.cornerRadius = 12
        wrapperView.clipsToBounds = true
    }
    
    func updateCell(model: FavoriteCollectionCellModel) {
        cityLabel.text = model.place.city
        countryLabel.text = model.place.country
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(model.place.lat), longitude: CLLocationDegrees(model.place.lon))
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(coordinateRegion, animated: false)
    }
}
