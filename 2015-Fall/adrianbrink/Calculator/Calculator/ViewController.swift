//
//  ViewController.swift
//  Calculator
//
//  Created by aevitas on 01/09/15.
//  Copyright (c) 2015 aevitas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsTyping = true
        }
    }

    @IBAction func clearDisplay(sender: UIButton) {
        let key = sender.currentTitle!
        if key == "Del" {
            display.text = "0"
            userIsTyping = false
        }
    }

    /* Stuff doesn't work yet.
    @IBAction func addNumbers(sender: UIButton) {
        userIsTyping = false
        var firstNumber = ""
        var firstNumberInt = 0
        firstNumber = display.text!
        firstNumberInt = firstNumber
        
        let key = sender.currentTitle!
        if key == "+" {
            
        }
    }
    */
}

