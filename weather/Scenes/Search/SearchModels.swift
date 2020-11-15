//
//  SearchModels.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation

enum Search {
    
    struct Data {
        var searchResults: [PlaceModel] = []
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
