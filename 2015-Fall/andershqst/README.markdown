## PushPopNavigation

Demos push pop navigation between two view controllers with no storyboard, with views loaded programatically.

* Create a new project using e.g. 'Single View Application'
* Delete all .storyboard files
* Open Info.plist and delete the row 'Main storyboard file base name'
* Add a new UIViewController (cmd+n, source>Cocoa Touch Class), name it e.g. `SecondViewController`, set 'subclass of' to `UIVewController`
* Add a new view - cmd+n, User Interface>View, name it `FirstView`
* Add a new view - cmd+n, User Interface>View, name it `SecondView`
* Now we need to connect the .xib a `UIViewController`. This involves loading the view, and setting the view as an outlet to the controller
    * Open FirstView.xib in interface builder
        * Tap "File's Owner" (yellow 3d box to the left)
        * In the File Inspector (if not show, open it via the View>Utilities) tap on 'Show the indentity inspector'
        * In the "Custom class" field write/find `FirstViewController`
        * Now control+drag from the "File's owner" to the view. Will show "Outlets" from where you click on "view"
* Do the same as above for SecondView.xib with `SecondViewController` as the "Custom class"
* Add buttons with actions from the views to the controllers as usual, and implement the navigation logic as shows in the demo code.  

## Other
With this approach it is also easy to pop to any `UIViewController` in the `UINavigationsController`'s stack

        let rootViewController = self.navigationController?.viewControllers.first
        self.navigationController?.popToViewController(rootViewController, animated: true);
