//
//  TabBarAccessoryViewController.swift
//  shOUT
//
//  Created by Matthew Coufal on 2/9/18.
//  Copyright © 2018 shOUT. All rights reserved.
//

import UIKit

protocol TabBarAccessoryViewControllerProtocol {
    func accessoryViewFrame() -> CGRect?
    func showAccessoryViewController(animated: Bool)
    func expandAccessoryViewController(animated: Bool)
    func collapseAccessoryViewController(animated: Bool)
    func hideAccessoryViewController(animated: Bool)
}

class TabBarAccessoryViewController: UIViewController, TabBarAccessoryViewControllerProtocol {
    
    func accessoryViewFrame() -> CGRect? {
        return nil
    }
    
    func showAccessoryViewController(animated: Bool) {
        
    }
    
    func expandAccessoryViewController(animated: Bool) {
        
    }
    
    func collapseAccessoryViewController(animated: Bool) {
        
    }
    
    func hideAccessoryViewController(animated: Bool) {
        
    }
}
