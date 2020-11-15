//
//  ForecastViewController.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import UIKit

protocol ForecastDisplayLogic: AnyObject {
    func display(viewmodel: Forecast.DataModel.ViewModel)
}

final class ForecastViewController: BaseViewController, IdentifierProtocol, ViewControllerIdentifierProtocol {
    
    static var storyboarIdentifier: String = StoryboardNames.forecast.name

    var interactor: ForecastBusinessLogic!
    var router: (ForecastRoutingLogic & ForecastDataPassing)!
    
    @IBOutlet private weak var tableView: UITableView!
    private var tableRows: [CellModel] = []
    
    deinit {
        print("🙏 Deinit ForecastViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMultilineTitle()
        interactor.loadForecast()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupView() {
        setupTableView()
    }
    
    private func setupMultilineTitle() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let title = NSMutableAttributedString(string: Date().toString(format: .dayMontYear),
                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(color: .gray)])
        if let city = router.dataStore?.data.place.city {
            let cityText = NSMutableAttributedString(string: "\n \(city)",
                                                     attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(color: .white)])
            title.append(cityText)
        }
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.attributedText = title
        self.navigationItem.titleView = label
        self.navigationItem.titleView?.isHidden = true
    }
    
    private func saveButtonTapped() {
        interactor.processSaveButtonTapped()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(color: .black)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.registerCell(cell: SimpleTextCell.self)
        tableView.registerCell(cell: ForecastTableCell.self)
        tableView.registerCell(cell: SimpleButtonCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = tableRows[indexPath.row]
        if let simpleTextCellModel = model as? SimpleTextCellModel {
            let cell: SimpleTextCell = tableView.resolveCellIdentifier()
            cell.updateCell(model: simpleTextCellModel)
            return cell
        }
        if let forecastCellModel = model as? ForecastTableCellModel {
            let cell: ForecastTableCell = tableView.resolveCellIdentifier()
            cell.updateCell(model: forecastCellModel)
            return cell
        }
        if let buttonCellModel = model as? SimpleButtonCellModel {
            let cell: SimpleButtonCell = tableView.resolveCellIdentifier()
            cell.updateCell(model: buttonCellModel)
            cell.action = { [weak self] in
                self?.saveButtonTapped()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationItem.titleView?.isHidden = scrollView.contentOffset.y < 60
    }
}

extension ForecastViewController: ForecastDisplayLogic {
    func display(viewmodel: Forecast.DataModel.ViewModel) {
        self.tableRows = viewmodel.tableRows
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
