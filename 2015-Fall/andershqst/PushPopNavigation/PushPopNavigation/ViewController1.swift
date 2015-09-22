//
//  ViewController1.swift
//  PushPopNavigation
//
//  Created by Anders Høst Kjærgaard on 22/09/2015.
//  Copyright © 2015 e-conomic International A/S. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {


    @IBAction func pushClick(sender: UIButton) {
        let vc = ViewController2()
        // Here, set things as you would do in prepare for segue...
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

