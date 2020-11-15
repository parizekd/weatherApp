//
//  MapPresenter.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation

protocol MapPresentationLogic: AnyObject {
    func present(response: Map.MapTypeModel.Response)
    func present(response: Map.MapAnnotationModel.Response)
}

final class MapPresenter {

    private weak var viewController: MapDisplayLogic?
    
    init(viewController: MapDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - PresentationLogic

extension MapPresenter: MapPresentationLogic {
    
    func present(response: Map.MapTypeModel.Response) {
        viewController?.display(viewModel: .init(style: response.style))
    }
    
    func present(response: Map.MapAnnotationModel.Response) {
        let locationName = response.placemark?.name ?? "Unknown"
        viewController?.display(viewModel: .init(location: response.location, name: locationName))
    }
}
