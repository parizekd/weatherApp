//
//  SearchInteractor.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation
import CoreLocation

protocol SearchBusinessLogic: AnyObject {
    func searchForPlaces(value: String)
}

protocol SearchDataStore: AnyObject {
    var data: Search.Data { get }
}

final class SearchInteractor: SearchDataStore {

    private let presenter: SearchPresentationLogic
    private(set) var data: Search.Data = Search.Data()

    init(presenter: SearchPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - BusinessLogic

extension SearchInteractor: SearchBusinessLogic {
    
    func searchForPlaces(value: String) {
        let coder = CLGeocoder()
        coder.geocodeAddressString(value) {[weak self] (result, error) in
            guard let self = self, let result = result else { return }
            self.data.searchResults = []
            for placemark in result {
                if let lat = placemark.location?.coordinate.latitude,
                   let lon = placemark.location?.coordinate.longitude,
                   let locality = placemark.locality {
                    let place = PlaceModel(lat: lat,
                                           lon: lon,
                                           name: placemark.name ?? "Unknown",
                                           city: locality,
                                           country: placemark.country ?? "Unknown",
                                           isFavorite: false)
                    self.data.searchResults.append(place)
                }
            }
            self.presenter.present(response: .init(rawData: self.data, error: error))
        }
    }
}
