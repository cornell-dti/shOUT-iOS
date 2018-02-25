//
//  PhoneNumberCell.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/8/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit
import Firebase

class Story {

    let ref: FIRDatabaseReference?
    let key: String?
    var title: String?
    var time: String?
    var content: String?  // if content == nil, then doesn't show up in stories tab
    var location: String?
    var coordinates: String?
    
    init(title: String?, time: String?, content: String?, key: String?, location: String?, coordinates: String?) {
        self.title = title
        self.time = time
        self.content = content
        self.location = location
        self.coordinates = coordinates
        self.key = nil
        self.ref = nil
    }
    
 //   func init(snapshot: FIRDataSnapshot) {
 //       key = snapshot.key
 //       ref = snapshot.ref
 //       let snapshotValue = snapshot.value as! [String: AnyObject]
 //       title = snapshotValue["title"] as! String
 //       time = snapshotValue["time"] as! String
 //       content = snapshotValue["content"] as! String
 //       location = snapshotValue["location"] as! String
 //       coordinates = snapshotValue["coordinates"] as! String
 //   }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "time": time,
            "content": content,
            "location": location,
            "coordinates": coordinates
        ]
    }
}
