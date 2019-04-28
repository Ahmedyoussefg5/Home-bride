//
//  MapSearchVC.swift
//  Testing-MapsSearch
//
//  Created by Demo on 8/2/16.
//  Copyright © 2016 Illuminated Bits LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HomeDelegate: class {
    func getSetlectedItem(item: MKMapItem)
}

class MapSearchVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableV = UITableView()
        tableV.isTransperant()
        tableV.separatorColor = .clear
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableV
    }()
    
    private let manager = CLLocationManager()
    let dataSourece = MapDataSource()
    weak var delegate: HomeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.fillSuperview()
        definesPresentationContext = true
        dataSourece.delegate = self
        tableView.dataSource = dataSourece
        tableView.delegate = dataSourece
        manager.delegate = dataSourece
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.locationServicesEnabled() {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func getAddress(coordinate: CLLocationCoordinate2D ,handler: @escaping (String) -> Void) {
        //var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary ?? "")
            
            let address = "\(placeMark?.thoroughfare ?? ""), \(placeMark?.locality ?? ""), \(placeMark?.subLocality ?? ""), \(placeMark?.administrativeArea ?? ""), \(placeMark?.postalCode ?? ""), \(placeMark?.country ?? "")"
            
            //print(address)
            handler(address)
        })
    }
}


extension MapSearchVC: MapDataSourceDelegate {
    func getSetlectedItem(item: MKMapItem) {
        delegate?.getSetlectedItem(item: item)
    }
    
    func refreshData() {
        tableView.reloadData()
    }
}



