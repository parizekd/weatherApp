//
//  Forecast.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

// MARK: - Forecast
struct ForecastModel: Codable {
    let lat: Double
    let current: CurrentForecast
    let timezone: String
    let daily: [Daily]
    let lon: Double
    let timezoneOffset: Int

    enum CodingKeys: String, CodingKey {
        case lat, current, timezone, daily, lon
        case timezoneOffset = "timezone_offset"
    }
}

// MARK: - CurrentForecast
struct CurrentForecast: Codable {
    let dt: Int
    let temp: Double
    let humidity, sunrise, sunset: Int
    let uvi: Double
    let windDeg: Int
    let weather: [Weather]
    let feelsLike: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let pressure: Int
    let dewPoint: Double

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity, sunrise, sunset, uvi
        case windDeg = "wind_deg"
        case weather
        case feelsLike = "feels_like"
        case clouds, visibility
        case windSpeed = "wind_speed"
        case pressure
        case dewPoint = "dew_point"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, icon, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case weatherDescription = "description"
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let humidity, sunrise, sunset: Int
    let uvi: Double
    let windDeg: Int
    let weather: [Weather]
    let feelsLike: FeelsLike
    let clouds: Int
    let windSpeed: Double
    let pressure: Int
    let dewPoint, pop: Double
    let rain: Double?
    
    var weekdayName: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        return date.toString(format: .weekDay)
    }
    var isToday: Bool {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        return Calendar.current.isDateInToday(date)
    }
    
    var iconUrl: String {
        if let icon = weather.first?.icon {
            return "https://openweathermap.org/img/w/" + icon + ".png"
        }
        return ""
    }

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity, sunrise, sunset, uvi
        case windDeg = "wind_deg"
        case weather
        case feelsLike = "feels_like"
        case clouds
        case windSpeed = "wind_speed"
        case pressure
        case dewPoint = "dew_point"
        case pop, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let night, eve, day, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let night, min, eve, day: Double
    let max, morn: Double
}
