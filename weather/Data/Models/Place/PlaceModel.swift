//
//  PlaceModel.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

struct PlaceModel: Equatable {
    let id: UUID?
    let lat: Double
    let lon: Double
    let name: String
    let city: String
    let country: String
    var isFavorite: Bool = false

    static func == (lhs: PlaceModel, rhs: PlaceModel) -> Bool {
        return lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
    
    init(lat: Double, lon: Double, name: String, city: String, country: String, isFavorite: Bool = false) {
        self.id = nil
        self.lat = lat
        self.lon = lon
        self.name = name
        self.city = city
        self.country = country
        self.isFavorite = isFavorite
    }
    
    init (place: Place) {
        self.id = place.placeId
        self.lat = place.lat
        self.lon = place.lon
        self.name = place.name ?? ""
        self.city = place.city ?? ""
        self.country = place.country ?? ""
        self.isFavorite = place.isFavorite
    }
}
