//
//  SearchPresenter.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation

protocol SearchPresentationLogic: AnyObject {
    func present(response: Search.DataModel.Response)
}

final class SearchPresenter {

    private weak var viewController: SearchDisplayLogic?
    
    init(viewController: SearchDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - PresentationLogic

extension SearchPresenter: SearchPresentationLogic {
    
    func present(response: Search.DataModel.Response) {
        var tableRows: [CellModel] = []
        for place in response.rawData.searchResults {
            tableRows.append(SearchResultCellModel(city: place.city, country: place.country))
        }
        viewController?.display(viewmodel: .init(tableRows: tableRows, error: nil))
    }
}
