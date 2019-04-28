//
//  ViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import MapKit

protocol SendMapResult: NSObjectProtocol {
    func location(name: String)
}

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    let mainView = HomeView()
    override func loadView() {
        view = mainView
        mainView.delegate = self
    }
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    
    var firstItem: MKMapItem? {
        didSet {
//            drawLine()
            mainView.searchBar.text = firstItem?.name
        }
    }
    
    var searchCompleter = MKLocalSearchCompleter()
    var places = [MKLocalSearchCompletion]()
    
    weak var delegate: SendMapResult?
    
    lazy var searchVC: MapSearchVC = {
        let vc = MapSearchVC()
        vc.delegate = self
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationServices()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "تأكيد", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissMePlease))
        navigationController?.navigationBar.tintColor = mediumPurple
        mainView.mapView.delegate = self
        locationManager.delegate = self
        searchCompleter.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        addDoubleTap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let txt = mainView.searchBar.text {
            delegate?.location(name: txt)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    func addDoubleTap() {
        let longPressGestureRecogn = UILongPressGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        longPressGestureRecogn.delegate = self
        longPressGestureRecogn.minimumPressDuration = 0.6
        mainView.mapView.addGestureRecognizer(longPressGestureRecogn)
    }
    
    @objc func dropPin(sender: UILongPressGestureRecognizer) {
        removePin()
        
        let touchPoint = sender.location(in: mainView.mapView)
        let touchCoordinate = mainView.mapView.convert(touchPoint, toCoordinateFrom: mainView.mapView)
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mainView.mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegion(center: touchCoordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mainView.mapView.setRegion(coordinateRegion, animated: true)
        
        firstItem = MKMapItem(placemark: MKPlacemark(coordinate: touchCoordinate))
        
        searchVC.getAddress(coordinate: touchCoordinate) {[weak self] (name) in
            print(name)
            self?.mainView.searchBar.text = name
        }
    }
    
    func locationCount() -> Int {
        return places.count
    }
    
    func locationAt(index:IndexPath) -> MKLocalSearchCompletion {
        return places[index.row]
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let annotation = DroppablePin(coordinate: coordinate, identifier: "droppablePin")
        mainView.mapView.addAnnotation(annotation)
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mainView.mapView.setRegion(coordinateRegion, animated: true)
        firstItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
    }
    
    func removePin() {
        for ann in mainView.mapView.annotations {
          mainView.mapView.removeAnnotation(ann)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        centerMapOnUserLocation()
    }
}

extension MapViewController: MKLocalSearchCompleterDelegate{
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        places = completer.results
        print(places)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    }
}

extension MapViewController: HomeCommunication {
    func search(with: String) {
        searchVC.dataSourece.searchText = with
        guard with.count > 0 else {
            mainView.childView.alpha = 0
            toRemoveChildViewController()
            return
        }
        
        mainView.childView.alpha = 1
        
        if children.count == 0 {
            toAddChildViewController(childViewController: searchVC, childViewControllerContainer: mainView.childView)
        }
    }
}

extension MapViewController: HomeDelegate {
    func getSetlectedItem(item: MKMapItem) {

        mainView.endEditing(true)
        removePin()

        let coordinate = item.placemark.coordinate
        let annotation = DroppablePin(coordinate: coordinate, identifier: "droppablePin")
        mainView.mapView.addAnnotation(annotation)
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mainView.mapView.setRegion(coordinateRegion, animated: true)
        
//        if sender == .fromSearchBar {
//            mainView.searchBar.text = item.name
            firstItem = item
        mainView.searchBar.text = firstItem?.name

//        } else {
//            mainView.toSearchBar.text = item.name
//            secoundItem = item
//        }
        mainView.childView.alpha = 0
    }
}


class DroppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}

extension CLLocationCoordinate2D {
    static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        print((lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude))
        return (lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude)
    }
    static func != (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        print((lhs.latitude == rhs.latitude || lhs.longitude == rhs.longitude))
        return (lhs.latitude != rhs.latitude || lhs.longitude != rhs.longitude)
    }
}
