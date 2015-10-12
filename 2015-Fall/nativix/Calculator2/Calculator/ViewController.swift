//
//  ViewController.swift
//  Calculator
//
//  Created by MARIA NATIVIDAD LARA DIAZ on 04/10/15.
//  Copyright © 2015 Appstract Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operateBinary(sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = false
        brain.pushNumber((display.text! as NSString).doubleValue)
        let result = brain.performBinaryOperation()
        if result != nil {
            displayValue = result!
            brain.pushNumber(result!)
        }
        brain.pushSymbol(sender.currentTitle!)
    }
    
    @IBAction func operateUnary(sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = false
        brain.pushNumber((display.text! as NSString).doubleValue)
        brain.pushSymbol(sender.currentTitle!)
        let result = brain.performUnaryOperation()
        if result != nil {
            displayValue = result!
            brain.pushNumber(result!)
        }
    }
    
    @IBAction func clearDisplay(sender: UIButton) {
        brain.clearDisplay()
        displayValue = 0
    }
    
    var displayValue: Double? {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            if newValue != nil
            {
                print ("hola")
                display.text = "\(newValue!)"
                userIsInTheMiddleOfTypingANumber = false
            } else{
                display.text = "ERROR"
                brain.clearDisplay()
            }
        }
    }
    
}

