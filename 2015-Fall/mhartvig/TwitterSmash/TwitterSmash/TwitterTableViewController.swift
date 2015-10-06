//
//  TwitterTableViewController.swift
//  TwitterSmash
//
//  Created by Martin Hartvig on 06/10/15.
//  Copyright © 2015 Martin Hartvig. All rights reserved.
//

import UIKit

class TwitterTableViewController: UITableViewController {

    private struct board {
       static let reuseIdentifier = "Tweet"
    }
    
    var tweets = [[Tweet]]()
    var searchQuery: String? = "#Copenhagen"
    
    private var lastRequst: TwitterRequest?
    private var nextRequest: TwitterRequest? {
        if lastRequst == nil {
            if let text = searchQuery {
                return TwitterRequest(search: text, count: 100)
            } else {
                return nil
            }
        } else {
            return lastRequst!.requestForNewer
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doQuery()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func doQuery() {
        if let request = nextRequest {
            request.fetchTweets { (requestedTweets) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if (!requestedTweets.isEmpty) {
                        self.tweets.insert(requestedTweets, atIndex: 0)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(board.reuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell
        cell.tweet = tweets[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
