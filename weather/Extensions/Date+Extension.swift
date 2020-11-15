//
//  Date+Extension.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

extension Date {
    
    enum Format: String {
        case dayMontYear = "dd.MM.yyyy"
        case weekDay = "cccc"
    }
    
    func toString(format: Format) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
