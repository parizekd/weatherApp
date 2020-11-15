//
//  BaseNavigationController.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor(color: .black)
        navigationBar.tintColor = UIColor(color: .purple)
    }
}
