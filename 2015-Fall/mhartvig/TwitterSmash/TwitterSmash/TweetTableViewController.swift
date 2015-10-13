//
//  TweetTableView.swift
//  TwitterSmash
//
//  Created by Martin Hartvig on 11/10/15.
//  Copyright © 2015 Martin Hartvig. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController {
    
    var SelectedTweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = SelectedTweet?.user?.screenName
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    

}
