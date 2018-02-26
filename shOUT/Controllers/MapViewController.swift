//
//  MapViewController.swift
//  shOUT
//
//  Created by Matthew Coufal on 2/25/18.
//  Copyright © 2018 shOUT. All rights reserved.
//

import UIKit
import Pulley

class MapViewController: PulleyViewController {
    
    var goOutViewController: GoOutViewController!
    var postViewController: PostViewController!
    var onMapViewController: ReachOutViewController!
    var pulleyViewController: PulleyViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavBar()
        
        goOutViewController = GoOutViewController()
        goOutViewController.mapViewController = self
        postViewController = PostViewController()
        postViewController.goOutViewController = goOutViewController
        onMapViewController = ReachOutViewController()
        pulleyViewController = PulleyViewController(contentViewController: goOutViewController, drawerViewController: onMapViewController)
        pulleyViewController.makeNavBar()
        
        let composeButton = UIBarButtonItem(title: "Compose", style: .plain, target: self, action: #selector(composeButtonPressed))
        navigationItem.setRightBarButton(composeButton, animated: true)
        
    }
    
    func emptyAddressAlert() {
        let message = "You left the location field empty. Nothing was added to the map."
        let alertController = UIAlertController(title: "Blank Address", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok.", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func composeButtonPressed() {
        present(postViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

