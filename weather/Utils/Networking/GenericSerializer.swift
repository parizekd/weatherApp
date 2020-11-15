//
//  GenericSerializer.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

final class GenericSerializer {
    
     func decodeData<T: Codable>(data: Data?, finalClass: T.Type) -> T? {
        guard let data = data else { return nil }
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            return nil
        }
    }
}
