//
//  SearchRouter.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import UIKit

protocol SearchRoutingLogic: AnyObject {
    func routeToForecast(place: PlaceModel)
}

protocol SearchDataPassing: AnyObject {
    var dataStore: SearchDataStore? { get }
}

final class SearchRouter: SearchDataPassing {

    private weak var viewController: SearchViewController?
    private(set) weak var dataStore: SearchDataStore?

    init(viewController: SearchViewController, dataStore: SearchDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: - RoutingLogic

extension SearchRouter: SearchRoutingLogic {
    func routeToForecast(place: PlaceModel) {
        let destination = ForecastConfigurator.create(with: place)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
