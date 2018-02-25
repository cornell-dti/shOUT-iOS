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
    var onMapViewController: ReachOutViewController!
    var pulleyViewController: PulleyViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavBar()
        
        goOutViewController = GoOutViewController()
        onMapViewController = ReachOutViewController()
        pulleyViewController = PulleyViewController(contentViewController: goOutViewController, drawerViewController: onMapViewController)
        pulleyViewController.makeNavBar()
        
        let composeButton = UIBarButtonItem(title: "Compose", style: .plain, target: self, action: #selector(composeButtonPressed))
        navigationItem.setRightBarButton(composeButton, animated: true)
        
    }
    
    @objc func composeButtonPressed() {
        present(PostViewController(), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

