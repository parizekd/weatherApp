//
//  BaseNavigationController.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(color: .white)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(color: .white)]
        appearance.backgroundColor = UIColor(color: .black)
        appearance.setBackIndicatorImage(UIImage(systemName: "arrow.backward.circle.fill"), transitionMaskImage: UIImage(systemName: "arrow.backward.circle.fill"))

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}
