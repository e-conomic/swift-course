//
//  ViewController2.swift
//  PushPopNavigation
//
//  Created by Anders Høst Kjærgaard on 22/09/2015.
//  Copyright © 2015 e-conomic International A/S. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBAction func popClicked(sender: UIButton) {
        // Or, tap on the back button
        self.navigationController?.popViewControllerAnimated(true);
    }
}
