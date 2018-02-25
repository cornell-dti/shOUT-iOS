//
//  AppDelegate.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/3/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit
import Firebase
import SnapKit
import Pulley

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var tabBarController: TabBarController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: UIControlState())
        
        let preferredDescriptor =
            UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        let font: UIFont = UIFont(name: "Trebuchet MS", size: preferredDescriptor.pointSize)!
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:
            font], for: UIControlState())
        
        tabBarController = TabBarController()
        tabBarController.addTab(index: 0, rootViewController: UINavigationController(rootViewController: FindOutViewController()), selectedImage: #imageLiteral(resourceName: "find_out"), unselectedImage: #imageLiteral(resourceName: "find_out"))
        tabBarController.addTab(index: 1, rootViewController: UINavigationController(rootViewController: SpeakOutViewController()), selectedImage: #imageLiteral(resourceName: "speak_out"), unselectedImage: #imageLiteral(resourceName: "speak_out"))
        let mapNav = UINavigationController(rootViewController: MapViewController(contentViewController: GoOutViewController(), drawerViewController: ReachOutViewController()))
        tabBarController.addTab(index: 2, rootViewController: mapNav, selectedImage: #imageLiteral(resourceName: "go_out"), unselectedImage: #imageLiteral(resourceName: "go_out"))
        tabBarController.addTab(index: 3, rootViewController: UINavigationController(rootViewController: ReachOutViewController()), selectedImage: #imageLiteral(resourceName: "reach_out"), unselectedImage: #imageLiteral(resourceName: "reach_out"))
        tabBarController.currentlyPresentedViewController = FindOutViewController()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension UIColor {
    @nonobjc class var shtCloudyBlue: UIColor {
        return UIColor(red: 182.0 / 255.0, green: 223.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        let platinum: UIColor = UIColor(hue: 0.2806, saturation: 0, brightness: 0.88, alpha: 1.0)
        self.layer.masksToBounds = false
        self.layer.shadowColor = platinum.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UILabel {
    func setBottomBorder() {
        self.layer.backgroundColor = UIColor.white.cgColor
        let platinum: UIColor = UIColor(hue: 0.2806, saturation: 0, brightness: 0.88, alpha: 1.0)
        self.layer.masksToBounds = false
        self.layer.shadowColor = platinum.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

