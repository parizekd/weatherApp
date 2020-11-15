//
//  Endpoints.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

enum ForecastApi {
    static let baseUrl: String = "https://api.openweathermap.org/data/"
    private static let apiKey = "f246202f50b4f35d025953256a0a41f7"
    
    enum ApiVersion: String {
        case latest = "2.5/"
    }
    
    enum Endpoints: String {
        case dailyForecast = "onecall"
    }
    
    static func weekForecast(lat: Double, lon: Double, apiVersion: ApiVersion = .latest) -> String {
        var url = "\(ForecastApi.baseUrl)\(apiVersion.rawValue)\(Endpoints.dailyForecast.rawValue)?lat=\(lat)&lon=\(lon)&units=metric&exclude=minutely,hourly"
        if Locale.current.languageCode == "sk" {
            url.append("&lang=sk")
        }
        return appendApiKey(url: url)
    }
    
    private static func appendApiKey(url: String) -> String {
        "\(url)&appid=\(ForecastApi.apiKey)"
    }
}
