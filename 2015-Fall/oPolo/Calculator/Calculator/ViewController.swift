//
//  ViewController.swift
//  Calculator
//
//  Created by Jonas Bruun Jacobsen on 11/07/15.
//  Copyright (c) 2015 Jonas Bruun Jacobsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var typingHistory: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalculatorBrain()

    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTypingHistory", name: "QueuedCalculationsChanged", object: nil)
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        /* 
        My implementation of the decimal point... If the user inputs a
        decimalpoint, and none is present so far, we allow them to add it.
        Explanation: If the user inputs a dec.point, we add it if there is
        no other dot present.. However, there can be a dot present from a result
        currently displayed after an operation, so it only matters if there is a dot in
        a number that is currently being typed.
        */
        if (digit == "." && userIsInTheMiddleOfTypingANumber &&
            (display.text!.rangeOfString(".") != nil)) {
            return
        }
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    /*
    This function is called, when the brain fires a notification that there has been changed in the
    queued of operations it has to do (i.e. someone has added new operands/operations and thus the
    typing history has changed). This function updates the GUI's typing history with the most new
    one according to the calculatorbrain.
    */
    func updateTypingHistory() {
        typingHistory.text! = brain.queuedOperations();
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
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
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func ResetCalculator() {
    
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

