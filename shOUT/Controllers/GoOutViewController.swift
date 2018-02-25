//
//  GoOutViewController.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/3/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol GoOutViewControllerDelegate {
    func addPinToMapAfterPostPressed(postViewController: PostViewController)
}

class GoOutViewController: UIViewController, MKMapViewDelegate, PostViewControllerDelegate {
    
    func postViewControllerDidTapPostButton(postViewController: PostViewController) {
    
    }
    
    var delegate: PostViewControllerDelegate?
    
    var mapView: MKMapView!
    
    var segmentedControl: UISegmentedControl!
    
    
    var geocoder = CLGeocoder()
    //    var geotifications = [Geotification]()
    var pin_array: [MKAnnotation] = []
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    var pinToUse = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView(frame: view.frame)
        mapView.delegate = self
        view.addSubview(mapView)
        segmentedControl = UISegmentedControl()
        let newPin = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(pressNewPin))
        navigationItem.leftBarButtonItem = newPin
        makeNavBar()
        
        // TODO Current location not working?
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        centerMapOnLocation(location: locationManager.location!)
        
        //        loadAllGeotifications()
        
        getMapPins()
        mapView.addAnnotations(pin_array)
        
        mapView.delegate = self
        // Do any additional setup after loading the view.
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        mapView.addGestureRecognizer(longGesture)
        let camera = MKMapCamera(lookingAtCenter: mapView.centerCoordinate, fromEyeCoordinate: mapView.centerCoordinate, eyeAltitude: 1000)
        mapView.setCamera(camera, animated: true)
    }
    
    func addPinToMap() {
        if let address = postViewController.locationTextField.text
        {
            if address == "" {
                self.emptyAddressAlert()
            }
            else{
                self.geocoder.geocodeAddressString(address) {
                    placemarks, error in
                    let placemark = placemarks?.first
                    let lat = placemark?.location?.coordinate.latitude
                    let long = placemark?.location?.coordinate.longitude
                    let location = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                    let localAnnotation = MKPointAnnotation()
                    localAnnotation.coordinate = location
                    localAnnotation.title = address
                    
                    localAnnotation.subtitle = "Potential Unsafe Zone"
                    self.mapView.addAnnotation(localAnnotation)
                    self.transformPins()
                    
                }
            }
            
        }
    }
    
    @objc func pressNewPin() {
        let addCategoryAlertController = UIAlertController(title: "Report an Address", message: "A pin will be added to the map, alerting other students that you found this location to be dangerous.", preferredStyle: .alert)
        addCategoryAlertController.addTextField { (textField) in
            textField.placeholder = "Address"
        }
        addCategoryAlertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            if let address = addCategoryAlertController.textFields?.first?.text
            {
                if address == "" {
                    self.emptyAddressAlert()
                }
                else{
                    self.geocoder.geocodeAddressString(address) {
                        placemarks, error in
                        let placemark = placemarks?.first
                        let lat = placemark?.location?.coordinate.latitude
                        let long = placemark?.location?.coordinate.longitude
                        let location = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                        let localAnnotation = MKPointAnnotation()
                        localAnnotation.coordinate = location
                        localAnnotation.title = address
                        
                        localAnnotation.subtitle = "Potential Unsafe Zone"
                        self.mapView.addAnnotation(localAnnotation)
                        self.transformPins()
                        
                    }
                }
                
            }
        }))
        addCategoryAlertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            addCategoryAlertController.dismiss(animated: true, completion: nil)
        }))
        
        present(addCategoryAlertController, animated: true, completion: nil)
        
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer){
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        let localAnnotation = MKPointAnnotation()
        localAnnotation.coordinate = locationCoordinate
        localAnnotation.subtitle = "Potential Unsafe Zone"
        self.mapView.addAnnotation(localAnnotation)
        self.transformPins()
    }
    
    func transformPins() {
        
        var arrayOfLocations: [(CLLocation, MKAnnotation)] = []
        var arrayOfCloseLocations: [(CLLocation, MKAnnotation)] = []
        var allCloseLocations: [[(CLLocation, MKAnnotation)]] = []
        let closeDistance = 100.0
        var threeDangerZones: [(CLLocation, MKAnnotation)] = []
        var fourDangerZones: [(CLLocation, MKAnnotation)] = []
        var fiveDangerZones: [(CLLocation, MKAnnotation)] = []
        
        let threeAnnotation = MKPointAnnotation()
        threeAnnotation.title = "Danger Zone (3)"
        
        let fourAnnotation = MKPointAnnotation()
        fourAnnotation.title = "Danger Zone (4)"
        
        let fiveAnnotation = MKPointAnnotation()
        fiveAnnotation.title = "Danger Zone (5)"
        
        
        for anno in mapView.annotations {
            let location = CLLocation(latitude: anno.coordinate.latitude, longitude: anno.coordinate.longitude)
            arrayOfLocations.append(location, anno)
        }
        
        for i in 0...arrayOfLocations.count-1 {
            for locAnno in arrayOfLocations {
                if arrayOfLocations[i].0.distance(from: locAnno.0) < closeDistance {
                    if threeDangerZones.count > 0 && threeDangerZones[i].0.distance(from: locAnno.0) < closeDistance {
                        print ("CLOSE TO A 3")
                    }
                    else {
                        arrayOfCloseLocations.append(locAnno)
                    }
                }
                
                //                if threeDangerZones.count > 0 {
                //                    if threeDangerZones[i].0.distance(from: locAnno.0) < closeDistance {
                //                        fourDangerZones.append(threeDangerZones[i])
                //                        threeDangerZones.remove(at: i)
                //                        mapView.removeAnnotation(threeDangerZones[i].1)
                //                        pinToUse = 4
                //                        mapView.addAnnotation(threeDangerZones[i].1)
                //                    }
                //                }
                //
                //                if fourDangerZones.count > 0 {
                //                    if fourDangerZones[i].0.distance(from: locAnno.0) < closeDistance {
                //                        fiveDangerZones.append(fourDangerZones[i])
                //                        fourDangerZones.remove(at: i)
                //                        mapView.removeAnnotation(fourDangerZones[i].1)
                //                        pinToUse = 5
                //                        mapView.addAnnotation(fourDangerZones[i].1)
                //                    }
                //                }
                
            }
            allCloseLocations.append(arrayOfCloseLocations)
            arrayOfCloseLocations = []
        }
        
        for arr in allCloseLocations {
            if arr.count == 3 {
                for locAnno in arr {
                    mapView.removeAnnotation(locAnno.1)
                    threeAnnotation.coordinate = locAnno.1.coordinate
                }
                pinToUse = 3
                mapView.addAnnotation(threeAnnotation)
                let threeAnnotationLocation = CLLocation(latitude: threeAnnotation.coordinate.latitude, longitude: threeAnnotation.coordinate.longitude)
                threeDangerZones.append((threeAnnotationLocation,threeAnnotation))
            }
        }
        pinToUse = 0
    }
    
    
    //            if arr.count == 4 {
    //                for locAnno in arr {
    //                    mapView.removeAnnotation(locAnno.1)
    //                    fourAnnotation.coordinate = locAnno.1.coordinate
    //                }
    //                pinToUse = 4
    //                mapView.addAnnotation(fourAnnotation)
    //                let fourAnnotationLocation = CLLocation(latitude: fourAnnotation.coordinate.latitude, longitude: fourAnnotation.coordinate.longitude)
    //                fourDangerZones.append((fourAnnotationLocation,fourAnnotation))
    //            }
    //            if arr.count == 5 {
    //                for locAnno in arr {
    //                    mapView.removeAnnotation(locAnno.1)
    //                    fiveAnnotation.coordinate = locAnno.1.coordinate
    //                }
    //                pinToUse = 5
    //                mapView.addAnnotation(fiveAnnotation)
    //                let fiveAnnotationLocation = CLLocation(latitude: fiveAnnotation.coordinate.latitude, longitude: fiveAnnotation.coordinate.longitude)
    //                fiveDangerZones.append((fiveAnnotationLocation,fiveAnnotation))
    //            }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        // TODO
        print ("here")
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = MKMapType.hybrid
        case 2:
            mapView.mapType = MKMapType.satellite
        default:
            mapView.mapType = MKMapType.standard
        }
    }
    
    func emptyAddressAlert() {
        let message = "You left the location field empty. Nothing was added to the map."
        let alertController = UIAlertController(title: "Blank Address", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok.", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func getMapPins() {
        pin_array = []
        // TODO
        //        var current: [Double] = []
        //
        //        let query = BackendlessDataQuery()
        //        let results = self.backendless.persistenceService.of(Locations.ofClass()).find(query)
        //        let currentPage = results.getCurrentPage()
        //
        //        for location in currentPage as! [Locations] {
        //            current.append(location.latitude)
        //            current.append(location.longitude)
        //
        //            // TODO, see if opacity can change with time
        //            //            let interval = location.created!.timeIntervalSinceNow
        //            //            current.append(interval)
        //
        //            pin_array.append(current)
        //
        //            current = []
        //        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let _ = "AnnotationIdentifier"
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "threepin")
        if pinToUse == 0 {
            return nil
        }
        if pinToUse == 3 {
            annotationView.image = UIImage(named: "3pin")
        }
        if pinToUse == 4 {
            annotationView.image = UIImage(named: "4pin")
        }
        if pinToUse == 5 {
            annotationView.image = UIImage(named: "5pin")
        }
        
        return annotationView
    }
    
}


extension GoOutViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .authorizedAlways)
    }
}

//extension GoOutViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if let annotation = annotation as? Constants.Pin {
//            // Better to make this class property
//            let annotationIdentifier = "AnnotationIdentifier"
//
//            var annotationView: MKAnnotationView?
//            if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
//                annotationView = dequeuedAnnotationView
//                annotationView?.annotation = annotation
//            }
//            else {
//                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            }
//
//            if let annotationView = annotationView {
//                // Configure your annotation view here
//                annotationView.canShowCallout = true
//                annotationView.image = UIImage(named: "Image")
//            }
//
//            return annotationView
//
//        }
//        return nil
//    }
//}


