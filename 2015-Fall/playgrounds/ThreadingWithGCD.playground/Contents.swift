//: Playground - noun: a place where people can play

import UIKit
// For async work in a playground
import XCPlayground

// Model - an image url
let url = NSURL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG3HHU9RhKoI-ZwNYf74jUXJmauzxqQECxY7_gAV59csdGQa4gWQ")!

let queue = dispatch_get_global_queue(NSQualityOfService.Background.rawValue, 0) // 0 is for the future
dispatch_async(queue) {
    // Download data
    guard let data = NSData(contentsOfURL: url) else {
        print("No data received - error handling? Do not fetch data like this...")
        return
    }
    
    // In playground, click on 'eye' icon to the right to see the image
    let image = UIImage(data: data)!
    dispatch_async(dispatch_get_main_queue()) {
        // set the image in the UI
    }
}

// XCPlayground
XCPSetExecutionShouldContinueIndefinitely()
