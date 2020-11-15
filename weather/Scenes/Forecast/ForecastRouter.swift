//
//  ForecastRouter.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import UIKit

protocol ForecastRoutingLogic: AnyObject {

}

protocol ForecastDataPassing: AnyObject {
    var dataStore: ForecastDataStore? { get }
}

final class ForecastRouter: ForecastDataPassing {

    private weak var viewController: ForecastViewController?
    private(set) weak var dataStore: ForecastDataStore?

    init(viewController: ForecastViewController, dataStore: ForecastDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    deinit {
        print("🙏 Deinit ForecastRouter")
    }
}

// MARK: - RoutingLogic

extension ForecastRouter: ForecastRoutingLogic {

}
