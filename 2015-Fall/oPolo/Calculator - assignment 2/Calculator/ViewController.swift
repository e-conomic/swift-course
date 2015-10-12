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
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()

    let calculationQueueChangedFunctionName = "QueuedCalculationsChanged"
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTypingHistory", name: calculationQueueChangedFunctionName, object: nil)
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
        typingHistory.text! = brain.description + " =";
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            displayValue = brain.performOperation(operation)
        }
    }
    
    @IBAction func StoreVariable() {
        if (displayValue != nil) {
            brain.variableValues["M"] = displayValue
        }
        userIsInTheMiddleOfTypingANumber = false
        
        //Lets reevaluate the brain, in case something uncomputable (such as M+M) just became computable
        displayValue = brain.evaluate()
    }
    
    @IBAction func LoadVariable() {
        //Just in case we were typing a number, before we push our variable onto the brain
        displayValue = brain.pushOperand("M");
        
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let displayedNumber = displayValue {
            //OK, we could parse whatever was on the display as a number, so we can safely give it to the brain
            if let result = brain.pushOperand(displayedNumber) {
                //There was operations on the stack to calculate, display them!
                displayValue = result
            } else {
                displayValue = nil
            }
        }
        else {
            //Whatever was currently displayed could not be parsed (somehow not a number?)
            //Resetting the display due to the invalid displayed data.
            displayValue = nil
        }
    }

    
    @IBAction func ResetCalculator() {
        brain.resetCalculator()
        displayValue = 0
        userIsInTheMiddleOfTypingANumber = false
    }
    
    //Returns nil if not parseable, else returns the display value
    //clears display if set to nil, else displays the value given.
    var displayValue: Double? {
        get {
            return Double(display.text!)
        }
        set {
            if (newValue != nil) {
                 display.text = "\(newValue!)" //We dont want it to write "Optional(0.0)"
            }
            else {
                display.text = " "; //clear display
            }
           
        }
    }
}

