//
//  ForecastPresenter.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import Foundation

protocol ForecastPresentationLogic: AnyObject {
    func present(response: Forecast.DataModel.Response)
}

final class ForecastPresenter {

    private weak var viewController: ForecastDisplayLogic?
    
    init(viewController: ForecastDisplayLogic) {
        self.viewController = viewController
    }
    
    deinit {
        print("🙏 Deinit ForecastPresenter")
    }
}

// MARK: - PresentationLogic

extension ForecastPresenter: ForecastPresentationLogic {
    
    func present(response: Forecast.DataModel.Response) {
        var tableRows: [CellModel] = []
        //Date and place
        tableRows.append(SimpleTextCellModel(text: Date().toString(format: .dayMontYear), labelSkin: LabelSkin.bodyGray, topSpacing: 20, bottomSpacing: 2))
        tableRows.append(SimpleTextCellModel(text: response.rawData.place.city, labelSkin: LabelSkin.bodyBoldLight, topSpacing: 2, bottomSpacing: 4))
        
        if let forecast = response.rawData.forecast {
            //Todays forecast
            tableRows.append(SimpleTextCellModel(text: "\(forecast.current.temp.roundedString)°C", labelSkin: .heading1Ligt, topSpacing: 42, bottomSpacing: 4))
            
            if let weatherDescription = forecast.current.weather.first?.weatherDescription.capitalizingFirstLetter() {
                tableRows.append(SimpleTextCellModel(text: weatherDescription, labelSkin: .heading2Light, topSpacing: 2, bottomSpacing: 2))
            }
            tableRows.append(SimpleTextCellModel(text: "\(Localizable.feelsLike.localized) \(forecast.current.feelsLike.roundedString)°C", labelSkin: .bodyGray, topSpacing: 2, bottomSpacing: 20))
            
            //Next days
            for day in forecast.daily where !day.isToday {
                tableRows.append(ForecastTableCellModel(day: day.weekdayName, humidity: day.humidity, temp: day.temp.max, iconUrl: day.iconUrl))
            }
            let buttonTitle = response.rawData.place.isFavorite ? Localizable.removeFromFavorites.localized : Localizable.addToFavorites.localized
            let titleColor: ThemeColor = response.rawData.place.isFavorite ? .red  : .purple
            tableRows.append(SimpleButtonCellModel(buttonTitle: buttonTitle, titleColor: titleColor))
        }
        
        viewController?.display(viewmodel: .init(place: response.rawData.place, tableRows: tableRows, error: nil))
    }
    
}
