//
//  ViewController.swift
//  Calculator
//
//  Created by Kristoffer Kunkel on 31/08/15.
//  Copyright (c) 2015 Kristoffer Kunkel. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!

    var typingNumber: Bool = false
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
    
        
        if typingNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            typingNumber = true
        }
        
        println("digit = \(digit)")
        
    }

}

