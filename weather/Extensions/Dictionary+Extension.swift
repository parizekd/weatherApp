//
//  Dictionary+Extension.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

public extension Dictionary {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            print("\(theJSONText)")
        }
    }
}
