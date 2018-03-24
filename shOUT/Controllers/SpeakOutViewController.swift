//
//  FindOutViewController.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/3/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit
import Firebase

class SpeakOutViewController: UITableViewController {
    
    var reports = [Report]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBar()
        print("view did load speak out")
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension

        Firestore.firestore().collection("reports").whereField("hasbody", isEqualTo: true).getDocuments { (snapshot, error) in
            if let error = error {
                print("error querying reports")
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    print(document.data())
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reports.count
    }
    
    override  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   //     var cell : BlogPost!
   //     var dateStr : String
   //
   //     cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BlogPost
   //
   //     let interval = posts[indexPath.row].datePosted
   //     let date = NSDate(timeIntervalSinceReferenceDate: interval!)
   //     let dateFormatter = DateFormatter()
   //
   //     if NSCalendar.current.isDateInToday(date as Date) {
    //        dateFormatter.dateFormat = "h:mm a"
    //        dateStr = "Today at " + dateFormatter.string(from: date as Date)
    //    }
    //
    //    else if NSCalendar.current.isDateInYesterday(date as Date) {
    //        dateFormatter.dateFormat = "h:mm a"
    //        dateStr = "Yesterday at " + dateFormatter.string(from: date as Date)
    //    }
    //
    //    else {
    //        dateFormatter.dateFormat = "MMM d, yyyy"
    //        dateStr = dateFormatter.string(from: date as Date)
    //    }

    //    print (dateStr)
    //    cell.time.text = dateStr
    //    cell.title.text = posts[indexPath.row].title
    //    cell.blogText.text = posts[indexPath.row].body
    //    return cell
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    
}
