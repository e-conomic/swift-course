//
//  TweetTableViewCell.swift
//  TwitterSmash
//
//  Created by Martin Hartvig on 06/10/15.
//  Copyright © 2015 Martin Hartvig. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetUsername: UILabel!
    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var tweetMessage: UILabel!
    
    var tweet: Tweet? {
        didSet {
            refreshUI()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshUI() {
        tweetImage.image = nil
        tweetMessage.text = nil
        tweetUsername.text = nil
        
        if let currentTweet = tweet {
            tweetUsername?.text = currentTweet.user.name
            
            var text = NSMutableAttributedString(string: currentTweet.text)
            
            text = highlightHashtag(text, items: currentTweet.hashtags, color: UIColor.blueColor())
            text = highlightHashtag(text, items: currentTweet.urls, color: UIColor.cyanColor())
            text = highlightHashtag(text, items: currentTweet.userMentions, color: UIColor.greenColor())
            
            tweetMessage.attributedText = text
            
            if let imageUrl = tweet?.user.profileImageURL {
                let queue = dispatch_get_global_queue(NSQualityOfService.UserInteractive.rawValue, 0) // 0 is for the future
                dispatch_async(queue) {
                    if let data = NSData(contentsOfURL: imageUrl) {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tweetImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    private func highlightHashtag(text: NSMutableAttributedString, items: [Tweet.IndexedKeyword], color: UIColor) -> NSMutableAttributedString {
        for item in items {
            text.addAttribute(NSForegroundColorAttributeName, value: color, range: item.nsrange)
        }
        return text
    }
}
