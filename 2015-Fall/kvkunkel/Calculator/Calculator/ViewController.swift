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
    
    var brain = CalculatorBrain()
    
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
    
    @IBAction func operate(sender: UIButton) {
        if typingNumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        typingNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }

}

