//
//  MapConfigurator.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation

struct MapConfigurator {

    private init() {}
    
    static func create() -> MapViewController {
        let viewController: MapViewController = MapViewController.loadFromStoryboard()
        let presenter = MapPresenter(viewController: viewController)
        let interactor = MapInteractor(presenter: presenter)
        let router = MapRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
