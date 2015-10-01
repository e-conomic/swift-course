// Threading
// This uses the infix operator (which we have no yet learned about) to create a nicer syntax for working with threads.
// This is not a powerful library, but rather a nifty way of hiding away ugly code.
// Also, it shows how infix operators in Swift can be used to extend the syntax of the language.

import Foundation

// This creates an infix operator, similar to + or *.
// Read more at https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html
infix operator >> {}

// The queue we want to run async
// This could also habe been done using the QOS system.
let queue = dispatch_queue_create("your_queue_name", nil)

// Assigning of a function to our previously created infix operator
func >> (background: () -> (), callback: () -> ()) {
    dispatch_async(queue) {
        background()
        dispatch_async(dispatch_get_main_queue(), callback)
    }
}

// Usage
// The first closure before >> is run in another thread.
// the second is run in the main thread when the first is done.
let threaded =
    { print("async") }
        >>
    { print("call back to main thread") }
