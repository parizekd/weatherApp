//
//  FavoritesInteractor.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import Foundation

protocol FavoritesBusinessLogic: AnyObject {
    func loadFavorites()
}

protocol FavoritesDataStore: AnyObject {
    var data: Favorites.Data { get }
}

final class FavoritesInteractor: FavoritesDataStore {

    private let presenter: FavoritesPresentationLogic
    private(set) var data: Favorites.Data = Favorites.Data()

    private lazy var placeRepository = PlaceRepository()

    init(presenter: FavoritesPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - BusinessLogic

extension FavoritesInteractor: FavoritesBusinessLogic {
    func loadFavorites() {
        data.places = placeRepository.getPlaces() ?? []
        presenter.present(response: .init(rawData: data, error: nil))
    }
}
