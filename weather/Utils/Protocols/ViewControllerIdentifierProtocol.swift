//
//  ViewControllerIdentifierProtocol.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation
import UIKit

protocol ViewControllerIdentifierProtocol {
    static var storyboarIdentifier: String { get }
}

extension ViewControllerIdentifierProtocol where Self: UIViewController, Self: IdentifierProtocol {

    static func loadFromStoryboard() -> Self {
        UIStoryboard.init(name: Self.storyboarIdentifier, bundle: Bundle.main).instantiateViewController(withIdentifier: Self.identifier) as! Self
    }
}
