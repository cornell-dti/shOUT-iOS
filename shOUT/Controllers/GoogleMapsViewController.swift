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
    func googleMapsViewControllerDidLongTap(googleMapsViewController: GoogleMapsViewController, location: CLLocationCoordinate2D)
}

class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    
    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}

class GoogleMapsViewController: UIViewController, GMSMapViewDelegate {

    var mapView: GMSMapView!
    var delegate: GoogleMapsViewControllerDelegate?
    var clusterManager: GMUClusterManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load googlemapsVC")
        let camera = GMSCameraPosition.camera(withLatitude: 42.4493233251, longitude: -76.4792276369, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - Constants.tabBarHeight * 1.5), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)

        clusterManager.cluster()
        
        view.addSubview(mapView)
    }
    
    func generateClusterItems(coordinate: CLLocationCoordinate2D) {
        let item = POIItem(position: coordinate, name: "Potential Dangerous Zone")
        clusterManager.add(item)
        clusterManager.cluster()
    }
    
    func populateMapWithCoordinate(coordinate: CLLocationCoordinate2D) {
//        let marker = GMSMarker(position: coordinate)
//        marker.appearAnimation = GMSMarkerAnimation.pop
//        marker.map = mapView
        generateClusterItems(coordinate: coordinate)
    }

    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        delegate?.googleMapsViewControllerDidLongTap(googleMapsViewController: self, location: coordinate)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
