//
//  ViewController.swift
//  Calculater
//
//  Created by Søren Dalby on 06/09/15.
//  Copyright (c) 2015 Søren Dalby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var display: UILabel!

    var continueCurrentNumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(continueCurrentNumber) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            continueCurrentNumber = true
        }
        
    }
    
}

