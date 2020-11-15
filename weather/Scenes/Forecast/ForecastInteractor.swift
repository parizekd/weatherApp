//
//  ForecastInteractor.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation

protocol ForecastBusinessLogic: AnyObject {
    func loadForecast()
    func processSaveButtonTapped()
}

protocol ForecastDataStore: AnyObject {
    var data: Forecast.Data { get }
}

final class ForecastInteractor: ForecastDataStore {

    private let presenter: ForecastPresentationLogic
    private(set) var data: Forecast.Data
    
    private lazy var forecastRepository = ForecastRepository()
    private lazy var placeRepository = PlaceRepository()

    init(presenter: ForecastPresentationLogic, place: PlaceModel) {
        self.presenter = presenter
        self.data = Forecast.Data(place: place)
    }
    
    deinit {
        print("🙏 Deinit ForecastInteractor")
    }
}

// MARK: - BusinessLogic

extension ForecastInteractor: ForecastBusinessLogic {
    
    func loadForecast() {
        forecastRepository.getWeeklyForecast(lat: data.place.lat, lon: data.place.lon) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let forecast):
                self.data.forecast = forecast
                self.presenter.present(response: .init(rawData: self.data, error: nil))
            case .failure(let error):
                self.presenter.present(response: .init(rawData: self.data, error: error))
            }
        }
    }
    
    func processSaveButtonTapped() {
        if data.place.isFavorite {
            if placeRepository.removePlace(place: data.place) {
                data.place.isFavorite.toggle()
            }
        } else {
            if let place = placeRepository.savePlace(place: data.place) {
                data.place = place
            }
        }
        presenter.present(response: .init(rawData: data, error: nil))
    }
    
}
