//
//  RootTabBarController.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import UIKit

final class RootTabBarController: UITabBarController, IdentifierProtocol, ViewControllerIdentifierProtocol {
    
    static var storyboarIdentifier: String = StoryboardNames.main.name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkin()
        setupTabs()
        NotificationCenter.default.addObserver(self, selector: #selector(onFavoriesDidChange(_:)), name: .favoritesDidChange, object: nil)
    }
    
    private func setupSkin() {
        tabBar.tintColor = UIColor(color: .purple)
        tabBar.barTintColor = UIColor(color: .black)
        tabBar.isTranslucent = false
        tabBar.addTopBorderWithColor(color: UIColor(color: .gray))
    }
    
    private func setupTabs() {
        viewControllers = [setupMapTab(),
                           setupSearchTab(),
                           setupFavoritesTab()]
        setutBadgeNumber()
    }
    
    private func setupMapTab() -> UINavigationController {
        let navigationController = BaseNavigationController()
        navigationController.pushViewController(MapConfigurator.create(), animated: false)
        navigationController.tabBarItem.image = UIImage(systemName: "map")
        navigationController.tabBarItem.title = Localizable.map.localized
    
        return navigationController
    }
    
    private func setupSearchTab() -> UINavigationController {
        let navigationController = BaseNavigationController()
        navigationController.pushViewController(SearchConfigurator.create(), animated: false)
        navigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationController.tabBarItem.title = Localizable.search.localized
    
        return navigationController
    }
    
    private func setupFavoritesTab() -> UINavigationController {
        let navigationController = BaseNavigationController()
        navigationController.pushViewController(FavoritesConfigurator.create(), animated: false)
        navigationController.tabBarItem.image = UIImage(systemName: "star")
        navigationController.tabBarItem.title = Localizable.favorites.localized
    
        return navigationController
    }
    
    @objc private func onFavoriesDidChange(_ notification: Notification) {
        setutBadgeNumber()
    }
    
    private func setutBadgeNumber() {
        if let tabItems = tabBar.items {
            let tabItem = tabItems[2]
            let count = PlaceRepository().getPlaces()?.count ?? 0
            tabItem.badgeValue = count > 0 ? String(count) : nil
        }
    }
}
