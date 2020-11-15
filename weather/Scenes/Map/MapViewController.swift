//
//  MapViewController.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import UIKit
import MapKit

protocol MapDisplayLogic: AnyObject {
    func display(viewModel: Map.MapTypeModel.ViewModel)
    func display(viewModel: Map.MapAnnotationModel.ViewModel)
}

final class MapViewController: BaseViewController, IdentifierProtocol, ViewControllerIdentifierProtocol {
    
    static var storyboarIdentifier: String = StoryboardNames.main.name
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var centerButton: UIButton!

    var interactor: MapBusinessLogic!
    var router: (MapRoutingLogic & MapDataPassing)!
    private lazy var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupView() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        segmentControl.setTitle(Localizable.standard.localized, forSegmentAt: 0)
        segmentControl.setTitle(Localizable.satelite.localized, forSegmentAt: 1)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.mapViewLongPressEvent(gestureRecognizer:)))
        lpgr.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(lpgr)
        
        segmentControl.defaultConfiguration()
    }
    
    private func setMapStyle(style: Map.MapStyle?) {
        guard let style = style else { return }
        switch style {
        case .satellite:
            mapView.mapType = .satellite
        case .standard:
            mapView.mapType = .standard
        }
    }
    
    private func addMapAnnotation(location: CLLocation, name: String) {
        let annotation = MKPointAnnotation()
        let coordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        annotation.coordinate = coordinates
        annotation.title = name
        
        mapView.addAnnotation(annotation)
    }
    
    private func showLocationPermissionAlert() {
        UIAlertWorker.showAlert(title: Localizable.alert.localized, message: Localizable.locationPermissionDenied.localized, presentingController: self)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                showLocationPermissionAlert()
            default:
                break
            }
        }
    }
    
    @objc func mapViewLongPressEvent(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            interactor.appMapPin(location: location)
        }
    }
    
    @IBAction func centerButtonTapped(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            default:
                showLocationPermissionAlert()
            }
        } else {
            showLocationPermissionAlert()
        }
    }
    
    @IBAction func segmentControlSelectedChanged(_ sender: Any) {
        guard let style = Map.MapStyle(rawValue: segmentControl.selectedSegmentIndex) else { return }
        interactor.changeMapStyle(style: style)
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            showLocationPermissionAlert()
        default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let location = view.annotation?.coordinate else { return }
        router.routeToForecast(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinateRegion = MKCoordinateRegion(center: locations.first!.coordinate,
                                                         latitudinalMeters: 1000, longitudinalMeters: 1000)

        mapView.setRegion(coordinateRegion, animated: true)
        if mapView.userLocation.location?.coordinate != nil {
            locationManager.stopUpdatingLocation()
        }
    }
}

extension MapViewController: MapDisplayLogic {
    
    func display(viewModel: Map.MapAnnotationModel.ViewModel) {
        addMapAnnotation(location: viewModel.location, name: viewModel.name)
    }
    
    func display(viewModel: Map.MapTypeModel.ViewModel) {
        setMapStyle(style: viewModel.style)
    }
}
