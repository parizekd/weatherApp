//
//  FavoritesModels.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation

enum Favorites {
    
    struct Data {
        var places: [PlaceModel] = []
    }
    
    enum DataModel {
        struct Response {
            let rawData: Data
            let error: Error?
        }
        
        struct ViewModel {
            let tableRows: [CellModel]
            let error: Error?
        }
    }
}
