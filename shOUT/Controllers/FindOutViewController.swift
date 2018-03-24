//
//  FindOutViewController.swift
//  shOUT
//
//  Created by Jordan Greissman on 1/3/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit

class FindOutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stories = [Report]()
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBar()
        
        self.tableView = UITableView()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let newsButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(press))
        navigationItem.leftBarButtonItems?.append(newsButton)
        
        let newsButton2 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(press2))
        navigationItem.leftBarButtonItems?.append(newsButton2)
        
        navigationItem.setLeftBarButtonItems([newsButton,newsButton2], animated: true)
        
        let composeButton = UIBarButtonItem(title: "Compose", style: .plain, target: self, action: #selector(composeButtonPressed))
        navigationItem.setRightBarButton(composeButton, animated: true)

        // Do any additional setup after loading the view.
    }
    
    @objc func composeButtonPressed() {
        present(PostViewController(), animated: true, completion: nil)
    }
    
    @objc func press() {
        navigationController?.pushViewController(BlogViewController(), animated: true)
    }

    @objc func press2() {
        navigationController?.pushViewController(NewsFeed2ViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
 //       var cell : BlogPost!
 //       cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogPost

//        cell.blogText.text = yaks[indexPath.row]
//        cell.time.text = "\((indexPath.row + 1) * 1)m ago"
//        return cell
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
