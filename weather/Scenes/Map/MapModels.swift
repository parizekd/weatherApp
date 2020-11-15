//
//  MapModels.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation
import CoreLocation

enum Map {

    struct Data {
        var places: [PlaceModel] = []
    }
    
    enum MapStyle: Int {
        case standard = 0
        case satellite = 1
    }
    
    enum MapTypeModel {
        struct Response {
            let style: MapStyle
        }
        
        struct ViewModel {
            let style: MapStyle
        }
    }
    
    enum MapAnnotationModel {
        struct Response {
            let location: CLLocation
            let placemark: CLPlacemark?
        }
        
        struct ViewModel {
            let location: CLLocation
            let name: String
        }
    }
}
