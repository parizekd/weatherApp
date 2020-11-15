//
//  SearchConfigurator.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation

struct SearchConfigurator {

    private init() {}
    
    static func create() -> SearchViewController {
        let viewController: SearchViewController = SearchViewController.loadFromStoryboard()
        let presenter = SearchPresenter(viewController: viewController)
        let interactor = SearchInteractor(presenter: presenter)
        let router = SearchRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
