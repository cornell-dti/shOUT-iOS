//
//  Extensions.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/9/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func requiredHeight() -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}

extension UIViewController {
    func makeNavBar() {
        let nav = self.navigationController?.navigationBar
        let lightTeal = UIColor(red:0.6, green:0.78, blue:0.74, alpha:1.0)
        
        nav?.barTintColor = lightTeal
        nav?.isTranslucent = true
    }
}
