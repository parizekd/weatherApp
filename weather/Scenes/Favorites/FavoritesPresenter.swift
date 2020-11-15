//
//  FavoritesPresenter.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation

protocol FavoritesPresentationLogic: AnyObject {
    func present(response: Favorites.DataModel.Response)
}

final class FavoritesPresenter {

    private weak var viewController: FavoritesDisplayLogic?
    
    init(viewController: FavoritesDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - PresentationLogic

extension FavoritesPresenter: FavoritesPresentationLogic {
    
    func present(response: Favorites.DataModel.Response) {
        var cells: [CellModel] = []
        for place in response.rawData.places {
            cells.append(FavoriteCollectionCellModel(place: place))
        }
        viewController?.display(viewmodel: .init(tableRows: cells, error: nil))
    }    
}
