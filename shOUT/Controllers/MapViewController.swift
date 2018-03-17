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
    
    func googleMapsViewControllerDidLongTap(googleMapsViewController: GoogleMapsViewController, location: CLLocationCoordinate2D) {
        print("did long tap")
        let loc: String = "\(location.latitude), \(location.longitude)"
        postViewController.location = loc
        postViewController.autoFillLocation(location: loc)
        postViewController.currLocation = location
        present(postViewController, animated: true, completion: nil)
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

