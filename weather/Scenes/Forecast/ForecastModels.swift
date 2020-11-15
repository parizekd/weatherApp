//
//  ForecastModels.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation
import CoreLocation

enum Forecast {
    
    struct Data {
        var place: PlaceModel
        var forecast: ForecastModel?
    }
    
    enum DataModel {
        struct Response {
            let rawData: Data
            let error: Error?
        }
        
        struct ViewModel {
            let place: PlaceModel?
            let tableRows: [CellModel]
            let error: Error?
        }
    }
}
