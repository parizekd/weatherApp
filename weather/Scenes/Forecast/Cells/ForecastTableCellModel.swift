//
//  ForecastTableCellModel.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

struct ForecastTableCellModel: CellModel {
    let day: String
    let humidity: String
    let temp: String
    let iconUrl: String
    
    init(day: String, humidity: Int, temp: Double, iconUrl: String) {
        self.day = day
        self.humidity = "\(humidity)%"
        self.temp = "\(temp.roundedString)°C"
        self.iconUrl = iconUrl
    }
}
