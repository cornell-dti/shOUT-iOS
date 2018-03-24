//
//  Report.swift
//  shOUT
//
//  Created by Matthew Coufal on 3/23/18.
//  Copyright © 2018 shOUT. All rights reserved.
//

import UIKit
import Firebase

class Report {
    
    var body: String!  // it's a story if the body is not empty
    var locationLabel: String!
    var locationLat: Double!
    var locationLong: Double!
    var timestamp: Int!
    var title: String!
    var uid: String!
    let key: String!
    let ref: DatabaseReference?
    
    init(body: String!, locationLabel: String!, locationLat: Double!, locationLong: Double!, timestamp: Int!, title: String!, uid: String!, key: String!) {
        self.body = body
        self.locationLabel = locationLabel
        self.locationLat = locationLat
        self.locationLong = locationLong
        self.timestamp = timestamp
        self.title = title
        self.uid = uid
        self.key = key
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        let snapshotValue = snapshot.value as! [String : AnyObject]
        body = snapshotValue["body"] as! String
        locationLabel = snapshotValue["locationLabel"] as! String
        locationLat = snapshotValue["locationLat"] as! Double
        locationLong = snapshotValue["locationLong"] as! Double
        timestamp = snapshotValue["timestamp"] as! Int
        title = snapshotValue["title"] as! String
        uid = snapshotValue["uid"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "body": body,
            "locationLabel": locationLabel,
            "locationLat": locationLat,
            "locationLong": locationLong,
            "timestamp": timestamp,
            "title": title,
            "uid": uid
        ]
    }
}
