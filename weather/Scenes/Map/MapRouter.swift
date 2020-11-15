//
//  MapRouter.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import UIKit
import CoreLocation

protocol MapRoutingLogic: AnyObject {
    func routeToForecast(location: CLLocationCoordinate2D)
}

protocol MapDataPassing: AnyObject {
    var dataStore: MapDataStore? { get }
}

final class MapRouter: MapDataPassing {

    private weak var viewController: MapViewController?
    private(set) weak var dataStore: MapDataStore?

    init(viewController: MapViewController, dataStore: MapDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

// MARK: - RoutingLogic

extension MapRouter: MapRoutingLogic {
    
    func routeToForecast(location: CLLocationCoordinate2D) {
        guard let place = dataStore?.data.places.first(where: { $0.lat == location.latitude && $0.lon == location.longitude }) else { return }
        let destination = ForecastConfigurator.create(with: place)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
