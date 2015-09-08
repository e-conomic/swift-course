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
    var lastAction: Bool = false
    var lastValue = 0
    var newValue = 0
    
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

    @IBAction func clearDisplay() {
        display.text = "0"
        lastValue = 0
        lastAction = false
        userIsTyping = false
    }
    
    @IBAction func operators(sender: UIButton) {
        let currentSymbol = sender.currentTitle!
        var lastSymbol = ""
        
        if (lastAction == true) {
            calculation(lastValue, symbol: lastSymbol)
        } else {
            lastValue = (display.text! as NSString).integerValue
            lastSymbol = currentSymbol
            lastAction = true
            display.text = "0"
            userIsTyping = false
        }
    }
    
    func calculation(lastValue: Int, symbol: String) {
        var currentValue = (display.text! as NSString).integerValue

        
        switch symbol {
            case "+":
                newValue = lastValue + currentValue
            case "-":
                newValue = lastValue - currentValue
            case "*":
                newValue = lastValue * currentValue
            case "/":
                newValue = lastValue / currentValue
            default:
                break
        }
        
        display.text = "\(newValue)"
    }
}

