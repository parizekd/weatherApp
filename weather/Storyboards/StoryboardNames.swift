//
//  StoryboardNames.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation

enum StoryboardNames: String {
    case main = "Main"
    case forecast = "Forecast"
    
    var name: String {
        return self.rawValue
    }
}
