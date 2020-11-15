//
//  Double+Extension.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

extension Double {
    var roundedString: String {
        return String(format: "%.0f", self.rounded())
    }
}
