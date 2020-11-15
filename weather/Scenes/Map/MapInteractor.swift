//
//  MapInteractor.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation
import CoreLocation

protocol MapBusinessLogic: AnyObject {
    func changeMapStyle(style: Map.MapStyle)
    func appMapPin(location: CLLocation)
}

protocol MapDataStore: AnyObject {
    var data: Map.Data { get }
}

final class MapInteractor: MapDataStore {

    private let presenter: MapPresentationLogic
    private(set) var data = Map.Data()

    init(presenter: MapPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - BusinessLogic

extension MapInteractor: MapBusinessLogic {
    
    func appMapPin(location: CLLocation) {
        let geocorder = CLGeocoder()
        geocorder.reverseGeocodeLocation(location) { [weak self] (placemarks, _) in
            guard let self = self, let placemark = placemarks?.first else { return }
            let locationName = placemark.name ?? "Unknown"
            let country = placemark.country ?? "Unknown"
            let city = placemark.locality ?? "Unknown"
            
            let place = PlaceModel(lat: location.coordinate.latitude,
                                   lon: location.coordinate.longitude,
                                   name: locationName,
                                   city: city,
                                   country: country)
            self.data.places.append(place)
            
            self.presenter.present(response: .init(location: location, placemark: placemarks?.first))
        }
    }
    
    func changeMapStyle(style: Map.MapStyle) {
        presenter.present(response: .init(style: style))
    }
}
