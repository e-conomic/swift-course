//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by aevitas on 15/10/15.
//  Copyright © 2015 adrian. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    func updateUI() {
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += "📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageUrl = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageUrl) {
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
        }
    }
}
