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
    
    @IBOutlet weak var historyDisplay: UILabel!

    var typingNumber: Bool = false
    var currentFloat: Bool = false
    
    var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        historyDisplay.text = ""
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        println("history: \(brain.getHistory())")
        let digit = sender.currentTitle!
        
        if currentFloat == false {
            if typingNumber {
                display.text = display.text! + digit
            } else {
                display.text = digit
                typingNumber = true
            }
        } else {
            if digit != "." {
                if typingNumber  {
                    display.text = display.text! + digit
                } else {
                    display.text = digit
                    typingNumber = true
                }
            }
        }
        historyDisplay.text = brain.getHistory()
        if digit == "." {
            currentFloat = true
        }
        
        println("digit = \(digit)")
        
    }
    
    @IBAction func operate(sender: UIButton) {
        historyDisplay.text = brain.getHistory()
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
        historyDisplay.text = brain.getHistory()
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

    @IBAction func clear() {
        historyDisplay.text = ""
        display.text = "0"
        brain.clearOpstack()
    }
    
}

