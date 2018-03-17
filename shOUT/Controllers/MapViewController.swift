//
//  MapViewController.swift
//  shOUT
//
//  Created by Matthew Coufal on 2/25/18.
//  Copyright © 2018 shOUT. All rights reserved.
//

import UIKit
import Pulley
import MapKit
import GoogleMaps

class MapViewController: PulleyViewController, GoogleMapsViewControllerDelegate, PostViewControllerDelegate {
    
    var postViewController: PostViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load mapVC")
        if let googleMapsViewController = primaryContentViewController as? GoogleMapsViewController {
            googleMapsViewController.delegate = self
        }
        
        postViewController = PostViewController()
        postViewController.delegate = self
        
        makeNavBar()
        
        let composeButton = UIBarButtonItem(title: "Compose", style: .plain, target: self, action: #selector(composeButtonPressed))
        navigationItem.setRightBarButton(composeButton, animated: true)
        
    }
    
    func getAddress(coordinate: CLLocationCoordinate2D) -> String {
        let geocoder = GMSGeocoder()
        var addr: String = ""
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            if let error = error {
                // handle errors later
                print("a")
            } else {
                print("b")
                guard let address = response?.firstResult(), let lines = address.lines else { return }
                addr = lines.joined(separator: " ")
            }
        }
        print("c")
        return addr
    }
    
    func googleMapsViewControllerDidLongTap(googleMapsViewController: GoogleMapsViewController, location: CLLocationCoordinate2D) {
        print("did long tap")
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location) { (response, error) in
            if let error = error {
                // alert controller
                let alertController = UIAlertController(title: "Invalid address", message: "There was an error in locating the address. Try again.", preferredStyle: .actionSheet)
                alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
            } else {
                guard let address = response?.firstResult(), let lines = address.lines else { return }
                let loc: String = lines.joined(separator: " ")
                self.postViewController.location = loc
                self.postViewController.autoFillLocation(location: loc)
                self.postViewController.currLocation = location
                self.present(self.postViewController, animated: true, completion: nil)
            }
        }
    }
    
    func postViewControllerDidTapPostButton(postViewController: PostViewController) {
        print("did tap post button")
        if let googleMapsViewController = primaryContentViewController as? GoogleMapsViewController {
            print("populating map")
            googleMapsViewController.populateMapWithCoordinate(coordinate: postViewController.currLocation!)
        }
    }
    
    func emptyAddressAlert() {
        let message = "You left the location field empty. Nothing was added to the map."
        let alertController = UIAlertController(title: "Blank Address", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok.", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func composeButtonPressed() {
        postViewController.autoFillLocation(location: "Inset your location here")
        present(postViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

