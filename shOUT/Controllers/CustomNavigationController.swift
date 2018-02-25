//
//  CustomNavigationController.swift
//  FWord
//
//  Created by Julia Sun on 5/16/16.
//  Copyright © 2016 Julia Sun. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationBarDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
        
        // change color of nav bar
        let lightTeal = UIColor(red:0.6, green:0.78, blue:0.74, alpha:1.0)
        navigationBar.barTintColor = lightTeal
        navigationBar.isTranslucent = true
        navigationBar.delegate = self
        
    }
    
    func openInfo() {
        print("Open Info")
    }
    
    func openWrite() {
        print("Open Write")
//         TODO, make this not look like shit
//        let modalViewController = PostViewController()
//        modalViewController.modalPresentationStyle = .overCurrentContext
//        present(modalViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
