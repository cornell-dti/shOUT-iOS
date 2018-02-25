//
//  NewsFeedTableViewCell.swift
//  shOUT
//
//  Created by Matthew Coufal on 12/1/17.
//  Copyright © 2017 shOUT. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var locationLabel: UILabel!
    var storyTextView: UITextView!
    var postDateLabel: UILabel!
    var iconImageView: UIImageView!
    var box: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        box = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 214))
        box.backgroundColor = .white
        box.center = CGPoint(x: 375 / 2.0, y: box.center.y)
        addSubview(box)
        
        storyTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 325, height: 214 / 2.75))
        storyTextView.center.x = box.center.x
        storyTextView.center.y = box.center.y + 10
        storyTextView.isEditable = false
        storyTextView.isSelectable = false
        addSubview(storyTextView)
        
        titleLabel = UILabel(frame: CGRect(x: frame.width * 0.05, y: frame.width * 0.025, width: frame.width, height: frame.height))
        titleLabel.textColor = .darkGray
        box.addSubview(titleLabel)
        
        locationLabel = UILabel(frame: titleLabel.frame)
        locationLabel.textColor = .lightGray
        locationLabel.center.y = titleLabel.center.y + locationLabel.frame.height / 2.0
        box.addSubview(locationLabel)
        
        
        
        postDateLabel = UILabel()
        iconImageView = UIImageView()
        
        backgroundColor = .clear
    }
    
    func setUpCellWithInfo(title: String, location: String?, story: String, time: String) {
        titleLabel.text = title
        if let location = location {
            locationLabel.text = location
        } else {
            locationLabel.text = "Location unknown"
        }
        postDateLabel.text = time
        storyTextView.text = story
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
