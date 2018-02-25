//
//  Constants.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/9/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class Constants {

    class Post {
        var title : String!
        var body : String!
        var datePosted : Double!
        
        init(fromTitle title: String, fromBody body: String, fromDate date: NSDate) {
            self.title = title
            self.body = body
            self.datePosted = Date().timeIntervalSinceReferenceDate
        }
        
        init(snapshot: FIRDataSnapshot) {
            let snapshotValue = snapshot.value as! [String: AnyObject]
            self.title = snapshotValue["title"] as! String
            self.body = snapshotValue["body"] as! String
            self.datePosted = snapshotValue["date"] as! Double
        }
        
        func toAnyObject() -> AnyObject {
            return [
                "title": self.title,
                "body": self.body,
                "date": self.datePosted
            ] as AnyObject
        }
    }
    
    class Pin: NSObject, MKAnnotation {
        let title: String?
        let discipline: String?
        let coordinate: CLLocationCoordinate2D
        
        init(title: String, coordinate: CLLocationCoordinate2D, discipline: String) {
            self.title = title
            self.coordinate = coordinate
            self.discipline = discipline
            
            super.init()
        }
    }
    
    class Locations : NSObject {
        var objectId: String?
        var ownerId: String?
        var created: NSDate?
        
        var latitude: Double = 0
        var longitude: Double = 0
    }
}
