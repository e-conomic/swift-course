//
//  CalculatorViewController.swift
//  CalculatorV2
//
//  Created by Leonid Rusnac on 08/09/15.
//  Copyright (c) 2015 Leonid Rusnac. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var calculatorModel = CalculatorModel()
    var userIsInTheMiddleOfTypingANumber = false
    var pointWasInsertedInThisNumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        if let digit = sender.currentTitle {
            if userIsInTheMiddleOfTypingANumber {
                display.text = display.text! + digit
            } else {
                display.text = digit
                userIsInTheMiddleOfTypingANumber = true
            }
        }
    }

    @IBAction func clear() {
        calculatorModel.clear()
        display.text = "\(0)"
        userIsInTheMiddleOfTypingANumber = false
        pointWasInsertedInThisNumber = false
    }
    
    @IBAction func backspace() {
        // I let the user to backspace only if it is in middle of typing
        if userIsInTheMiddleOfTypingANumber {
            if let displayText = display.text {
                let newDisplay = String(displayText.characters.dropLast())
                if newDisplay.isEmpty {
                    userIsInTheMiddleOfTypingANumber = false
                    pointWasInsertedInThisNumber = false
                    display.text = "0"
                } else {
                    if let _ = newDisplay.rangeOfString(".") {
                    } else {
                        pointWasInsertedInThisNumber = false
                    }
                    display.text = newDisplay
                }
            }
        }
    }
    
    @IBAction func enter() {
        if userIsInTheMiddleOfTypingANumber {
            //push number and evaluate the stack
            if let val = displayValue {
                calculatorModel.pushNumber(val)
                if let res = calculatorModel.evaluate() {
                    displayValue = res
                }
                userIsInTheMiddleOfTypingANumber = false
                pointWasInsertedInThisNumber = false
            }
        }
    }
    
    @IBAction func point() {
        if !pointWasInsertedInThisNumber {
            if userIsInTheMiddleOfTypingANumber {
                display.text = display.text! + "."
            } else {
                display.text = "0."
                userIsInTheMiddleOfTypingANumber = true
            }
            pointWasInsertedInThisNumber = true
        }
    }
    
    @IBAction func addOperator(sender: UIButton) {
        enter()
        if let op = sender.currentTitle {
            calculatorModel.pushOpNotNumber(op)
            userIsInTheMiddleOfTypingANumber = false
            pointWasInsertedInThisNumber = false
        }
        
        if let res = calculatorModel.evaluate() {
            displayValue = res
        }
    }
    
    @IBAction func addConstant(sender: UIButton) {
        enter()
        
        if let op = sender.currentTitle {
            calculatorModel.pushOpNotNumber(op)
            userIsInTheMiddleOfTypingANumber = false
            pointWasInsertedInThisNumber = false
        }
        
        if let res = calculatorModel.evaluate() {
            displayValue = res
        }
    }
    
    
    var displayValue: Double? {
        get {
            return (display.text! as NSString).doubleValue
        }
        set {
            display.text = "\(newValue!)"
        }
    }
}
