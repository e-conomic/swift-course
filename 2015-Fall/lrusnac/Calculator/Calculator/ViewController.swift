//
//  ViewController.swift
//  Calculator
//
//  Created by Leonid Rusnac on 01/09/15.
//  Copyright (c) 2015 Leonid Rusnac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingANumber = false
    var pointWasInsertedInThisNumber = false
    var lastValue = 0.0
    var lastOperation: String?
    
    @IBAction func doOperation(sender: UIButton) {
        let operation = sender.currentTitle!
        if lastOperation != nil {
            evaluate()
        } else {
            lastValue = (display.text! as NSString).doubleValue
        }
        
        userIsInTheMiddleOfTypingANumber = false
        pointWasInsertedInThisNumber = false
        lastOperation = operation
    }
    
    @IBAction func clear() {
        lastValue = 0.0
        lastOperation = nil
        display.text = "0"
        userIsInTheMiddleOfTypingANumber = false
        pointWasInsertedInThisNumber = false
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func addPoint() {
        if !userIsInTheMiddleOfTypingANumber {
            userIsInTheMiddleOfTypingANumber = true
            display.text = "0."
        } else {
            if !pointWasInsertedInThisNumber {
                display.text = display.text! + "."
            }
        }
        pointWasInsertedInThisNumber = true
    }
    
    func evaluate() {
        let displayValue = (display.text! as NSString).doubleValue
        
        switch lastOperation! { //I am sure that last operation will be set
        case "-":
            lastValue -= displayValue
            break;
        case "+":
            lastValue += displayValue
            break;
        case "/":
            lastValue /= displayValue
            break;
        case "*":
            lastValue *= displayValue
            break;
        default:
            break
        }
        
        display.text = "\(lastValue)"
    }

}

