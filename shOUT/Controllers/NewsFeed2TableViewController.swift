//
//  NewsFeed2TableViewController.swift
//  shOUT
//
//  Created by Raymone Radi  on 12/1/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit

class Post {
    
    var postText: String
    var dateText: String
    
    init(postTextString: String, dateTextString: String) {
        self.postText = postTextString
        self.dateText = dateTextString
    }
}

    class NewsFeed2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewsFeedTableViewCell2Delegate {
        
        var tableView: UITableView!
        var posts = [Post]()

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            title = "News Feed"
            
            view.backgroundColor = .white
            
            tableView = UITableView(frame: view.frame)
            tableView.backgroundColor = .white
            tableView.tableFooterView = UIView()
            tableView.rowHeight = 100
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(NewsFeedTableViewCell2.self, forCellReuseIdentifier: "Reuse")
            view.addSubview(tableView)
            
            getData()
        }
        
        func getData() {
           posts.append(Post(postTextString: "Campus needs a reform!", dateTextString: "11/05/1998"))
           posts.append(Post(postTextString: "Don't go to this address anymore", dateTextString: "12/15/2000"))
           posts.append(Post(postTextString: "Cornell needs a change, soon.", dateTextString: "10/09/2017"))
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as? NewsFeedTableViewCell2{
                print (indexPath.row)
                print (posts.count)
                let post = posts[indexPath.row]
                cell.setup(dateTextString: post.dateText, postTextString: post.postText)
                cell.delegate = self
                return cell
            }
            
            return NewsFeedTableViewCell2(style: .default, reuseIdentifier: "Reuse")
            
        }
        
        func newsFeedTableViewCell2(newsFeedTableViewCell2: NewsFeedTableViewCell2) {
            //
        }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let grayBox = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
            return grayBox
        }

    }
