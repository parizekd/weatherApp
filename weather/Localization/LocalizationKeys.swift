//
//  LocalizationKeys.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation

enum Localizable: String {
    case map
    case search
    case favorites
    case standard
    case satelite
    case alert
    case locationPermissionDenied
    case addToFavorites
    case removeFromFavorites
    case feelsLike
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
