//
//  FavoritesConfigurator.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation

struct FavoritesConfigurator {

    private init() {}
    
    static func create() -> FavoritesViewController {
        let viewController: FavoritesViewController = FavoritesViewController.loadFromStoryboard()
        let presenter = FavoritesPresenter(viewController: viewController)
        let interactor = FavoritesInteractor(presenter: presenter)
        let router = FavoritesRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
