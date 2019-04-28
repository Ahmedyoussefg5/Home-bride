//
//  ViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import MapKit

protocol HomeCommunication: class {
    func search(with: String)
}

class HomeView: BaseView {
    let mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = ya
        return map
    }()
    lazy var searchBar: UISearchBar = {
        let se = UISearchBar()
        se.barTintColor = .clear
        se.backgroundImage = UIImage()
        se.returnKeyType = .done
        se.placeholder = "بحث".localize
        se.delegate = self
        return se
    }()
    
    let childView = UIView()
    weak var delegate: HomeCommunication?
    
    override func setupView() {
        addSubview(mapView)
        mapView.fillSuperview()
        
//        let locationStack = UIStackView(arrangedSubviews: [searchBar])
//        locationStack.axis = v
//        locationStack.distribution = .fillEqually
//        locationStack.spacing = 10
        addSubview(searchBar)
        ActivateConstraint([
            searchBar.centerXInSuperview(),
            searchBar.widthAnchorWithMultiplier(multiplier: 0.9),
            searchBar.topAnchorSuperView(constant: 10),
//            searchBar.heightAnchorConstant(constant: 80)
            ])
        
        addSubview(childView)
        childView.alpha = 0
        ActivateConstraint([
            childView.centerXInSuperview(),
            childView.widthAnchorWithMultiplier(multiplier: 0.95),
            childView.heightAnchorWithMultiplier(multiplier: 0.5),
            childView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5)
            ])
    }
}

extension HomeView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.search(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing(true)
    }
}
