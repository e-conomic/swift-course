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
    
    @IBOutlet weak var history: UILabel!
    
    var userIsTyping = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            if  digit == "." && display.text!.rangeOfString(".") != nil {
               return
            }
            else {
                display.text = display.text! + digit
            }
        }
        else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        
        if userIsTyping {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
                history.text = brain.history()
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
            history.text = brain.history()
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func clear() {
        displayValue = 0
        history.text = ""
        brain.clear()
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }
}