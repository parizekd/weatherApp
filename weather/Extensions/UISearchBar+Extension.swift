//
//  UISearchBar+Extension.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import UIKit

extension UISearchController {
    
    func setDefaultSearchBar() {
        self.searchBar.tintColor = UIColor(color: .purple)
        if let imageView = searchBar.searchTextField.leftView as? UIImageView {
            imageView.tintColor = UIColor(color: .purple)
        }
        searchBar.barStyle = .black
    }
    
}
