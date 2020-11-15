//
//  FavoritesViewController.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func display(viewmodel: Favorites.DataModel.ViewModel)
}

final class FavoritesViewController: BaseViewController, IdentifierProtocol, ViewControllerIdentifierProtocol {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    static var storyboarIdentifier: String = StoryboardNames.main.name

    var interactor: FavoritesBusinessLogic!
    var router: (FavoritesRoutingLogic & FavoritesDataPassing)!
    
    private var collectionItems: [CellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor.loadFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(onFavoriesDidChange(_:)), name: .favoritesDidChange, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupView() {
        title = Localizable.favorites.localized
        createCollectionViewLayout()
        collectionView.registerCell(cell: FavoriteCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func onFavoriesDidChange(_ notification: Notification) {
        interactor.loadFavorites()
    }
    
    private func createCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
            let size = CGSize(width: calculateCellWidth(), height: FavoriteCollectionCell.cellHeight)
            layout.itemSize = size
        }
    }
    
    private func calculateCellWidth() -> Int {
        let maxWidth = 220
        let screenInsets = 32
        let screenSize = Int(UIScreen.main.bounds.width) - screenInsets
        let spacing = 8
        
        let itemsPerRow = (screenSize) / maxWidth
        if itemsPerRow > 2 {
            let itemSize = CGFloat(screenSize) / CGFloat(itemsPerRow)
            return Int(itemSize) - spacing
        } else {
           return (screenSize) / 2 - spacing
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = collectionItems[indexPath.row]
        if let favoriteModel = model as? FavoriteCollectionCellModel {
            let cell: FavoriteCollectionCell = collectionView.resolveCellIdentifier(indexPath: indexPath)
            cell.updateCell(model: favoriteModel)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = collectionItems[indexPath.row] as? FavoriteCollectionCellModel else { return }
        router.routeToForecast(place: model.place)
    }
}

extension FavoritesViewController: FavoritesDisplayLogic {
    func display(viewmodel: Favorites.DataModel.ViewModel) {
        collectionItems = viewmodel.tableRows
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}
