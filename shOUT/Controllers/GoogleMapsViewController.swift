//
//  GoogleMapsViewController.swift
//  shOUT
//
//  Created by Raymone Radi  on 3/3/18.
//  Copyright © 2018 shOUT. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

protocol GoogleMapsViewControllerDelegate {
    func googleMapsViewControllerDidLongTap (googleMapsViewController: GoogleMapsViewController, location: CLLocationCoordinate2D)
}

class GoogleMapsViewController: UIViewController, GMSMapViewDelegate {

    var mapView: GMSMapView!
    var delegate: GoogleMapsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 42.4493233251, longitude: -76.4792276369, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - Constants.tabBarHeight), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        view.addSubview(mapView)
    }

    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = mapView
        delegate?.googleMapsViewControllerDidLongTap (googleMapsViewController: self, location: coordinate)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
