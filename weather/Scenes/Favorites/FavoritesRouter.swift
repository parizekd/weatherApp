//
//  FavoritesRouter.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import UIKit

protocol FavoritesRoutingLogic: AnyObject {
    func routeToForecast(place: PlaceModel)
}

protocol FavoritesDataPassing: AnyObject {
    var dataStore: FavoritesDataStore? { get }
}

final class FavoritesRouter: FavoritesDataPassing {

    private weak var viewController: FavoritesViewController?
    private(set) weak var dataStore: FavoritesDataStore?

    init(viewController: FavoritesViewController, dataStore: FavoritesDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: - RoutingLogic

extension FavoritesRouter: FavoritesRoutingLogic {
    func routeToForecast(place: PlaceModel) {
        let destination = ForecastConfigurator.create(with: place)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
