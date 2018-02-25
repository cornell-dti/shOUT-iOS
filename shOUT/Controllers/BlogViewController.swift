//
//  BlogViewController.swift
//  shOUT
//
//  Created by Matthew Coufal on 12/1/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var blogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavBar()

        blogTableView = UITableView(frame: view.frame)
        blogTableView.delegate = self
        blogTableView.dataSource = self
        blogTableView.register(UITableViewCell.self, forCellReuseIdentifier: "news")
        blogTableView.backgroundColor = .lightGray
        view.addSubview(blogTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let grayBox = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        return grayBox
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width / 1.75
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

