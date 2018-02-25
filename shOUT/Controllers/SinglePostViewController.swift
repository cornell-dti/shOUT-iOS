//
//  SinglePostViewController.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/9/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit

class SinglePostViewController: UIViewController {
    @IBOutlet var bodyView: UILabel!
    @IBOutlet var titleView: UILabel!

    
    var titleStringViaSegue: String!
    var bodyStringViaSegue: String!


    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBar()
        
        self.titleView.text = self.titleStringViaSegue
        self.bodyView.text = self.bodyStringViaSegue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
