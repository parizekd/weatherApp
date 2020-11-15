//
//  SearchViewController.swift
//  weather
//
//  Created by David Parizek on 14/11/2020.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func display(viewmodel: Search.DataModel.ViewModel)
}

final class SearchViewController: BaseViewController, IdentifierProtocol, ViewControllerIdentifierProtocol {
    
    static var storyboarIdentifier: String = StoryboardNames.main.name

    var interactor: SearchBusinessLogic!
    var router: (SearchRoutingLogic & SearchDataPassing)!
    
    @IBOutlet private weak var tableView: UITableView!
    private var tableRows: [CellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupView() {
        title = Localizable.search.localized
        let search = UISearchController(searchResultsController: nil)
        search.setDefaultSearchBar()
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(color: .black)
        tableView.tableFooterView = UIView()
        tableView.registerCell(cell: SearchResultCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = tableRows[indexPath.row]
        if let sesrchCellModel = model as? SearchResultCellModel {
            let cell: SearchResultCell = tableView.resolveCellIdentifier()
            cell.updateCell(model: sesrchCellModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let place = router.dataStore?.data.searchResults[indexPath.row] else { return }
        router.routeToForecast(place: place)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        interactor.searchForPlaces(value: searchController.searchBar.text ?? "")
    }
}

extension SearchViewController: SearchDisplayLogic {
    func display(viewmodel: Search.DataModel.ViewModel) {
        self.tableRows = viewmodel.tableRows
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
