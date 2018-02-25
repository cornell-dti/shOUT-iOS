//
//  NewsFeedTableViewCell.swift
//  shOUT
//
//  Created by Raymone Radi  on 12/1/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit

protocol NewsFeedTableViewCell2Delegate {
    func newsFeedTableViewCell2(newsFeedTableViewCell2: NewsFeedTableViewCell2)
}

class NewsFeedTableViewCell2: UITableViewCell {

    var dateText: UILabel!
    var postText: UILabel!
    var delegate: NewsFeedTableViewCell2Delegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    selectionStyle = .default
    
    dateText = UILabel()
    dateText.textColor = .black
    postText = UILabel()
    postText.font = UIFont(name: "Helvetica Bold", size: 20.0)

    
    addSubview(dateText)
    addSubview(postText)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(dateTextString: String, postTextString: String){
        dateText.text = dateTextString
        postText.text = postTextString
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateText.frame = CGRect (x: 0, y: frame.height / 2.0, width: frame.width, height: frame.height / 4.0)
        postText.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 4.0)
    }
    
    
}
