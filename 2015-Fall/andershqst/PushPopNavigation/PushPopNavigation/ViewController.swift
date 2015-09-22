//
//  ViewController.swift
//  PushPopNavigation
//
//  Created by Anders Høst Kjærgaard on 22/09/2015.
//  Copyright © 2015 e-conomic International A/S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    init() {
        // Load the UIViewControllers view from a .xib programatically
        super.init(nibName: "FirstView", bundle: NSBundle.mainBundle());
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func pushClick(sender: UIButton) {
        let vc = SecondViewController()
        // Here, set things as you would do in prepare for segue...
        // vc.happiness = 42
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

