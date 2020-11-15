//
//  ForecastConfigurator.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation

struct ForecastConfigurator {

    private init() {}
    
    static func create(with place: PlaceModel) -> ForecastViewController {
        let viewController: ForecastViewController = ForecastViewController.loadFromStoryboard()
        let presenter = ForecastPresenter(viewController: viewController)
        let interactor = ForecastInteractor(presenter: presenter, place: place)
        let router = ForecastRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
