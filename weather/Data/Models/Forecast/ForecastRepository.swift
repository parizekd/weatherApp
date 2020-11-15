//
//  ForecastRepository.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

final class ForecastRepository {
    
    private lazy var serializer = GenericSerializer()
    
    func getWeeklyForecast(lat: Double, lon: Double, completion: @escaping GenericCallback<Result<ForecastModel?, Error>>) {
        let url = ForecastApi.weekForecast(lat: lat, lon: lon)
        NetworkManager.shared.sendRequest(url: url, method: .GET) { [weak self] result in
            guard let self = self else {
                completion(.success(nil))
                return
            }
            
            switch result {
            case .success(let data):
                let forecast = self.serializer.decodeData(data: data, finalClass: ForecastModel.self)
                completion(.success(forecast))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
