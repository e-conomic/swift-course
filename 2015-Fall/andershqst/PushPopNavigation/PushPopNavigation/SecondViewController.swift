//
//  SecondViewController.swift
//  PushPopNavigation
//
//  Created by Anders Høst Kjærgaard on 22/09/2015.
//  Copyright © 2015 e-conomic International A/S. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    init() {
        // Load the UIViewControllers view from a .xib programatically
        super.init(nibName: "SecondView", bundle: NSBundle.mainBundle());
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Pop the navigation controller, same as tap on the back button that 
    // has been set for us by UINavigationController
    @IBAction func popClicked(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true);
    }
}
