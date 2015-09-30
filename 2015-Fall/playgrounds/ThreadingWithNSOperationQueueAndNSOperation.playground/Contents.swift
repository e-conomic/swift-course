//: Playground - noun: a place where people can play

import UIKit
// For async work in a playground
import XCPlayground

// Model - an image url
let url = NSURL(string: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTGSyKGEpTSvcN0jdRz3MRPcg0Nl5fOMh5oBrk7zPM60F3ySxUBAg")!

// Queue of blocks that we execute asynchroneously
let queue = NSOperationQueue()

// Create a NSOperation that encapsualtes some work
class MyOperation: NSOperation {
    
    private let url: NSURL
    var image: UIImage?
    
    init(url aUrl: NSURL) {
        url = aUrl
    }
    
    // main() is executed on a background thread, and is the only needed override
    // for asynchroneous operations. See docs for synchroneous operations
    override func main() {
        
        // For task that we may cancel underway, we can check this and abort
        if cancelled { return }
        
        if let data = NSData(contentsOfURL: url) {
            image = UIImage(data: data);
        }
    }
}

// Create an instance of MyOperation and submit it to the queue
let myOperation = MyOperation(url: url)
myOperation.completionBlock = {
    dispatch_async(dispatch_get_main_queue()) {
        let image = myOperation.image
    }
}
queue.addOperation(myOperation)

// XCPlayground
XCPSetExecutionShouldContinueIndefinitely()
