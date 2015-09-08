//
//  ViewController.swift
//  Calculator
//
//  Created by Martin Hartvig on 04/09/15.
//  Copyright (c) 2015 Martin Hartvig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    
    var isUserTyping: Bool = false;
    var isNumberADecimal: Bool = false;
    
    let brain = CalculatorBrian()
    
    override func viewDidLoad() {
        historyLabel.text = ""
    }
    
    var displayValue: Double? {
        get {
            if let value = NSNumberFormatter().numberFromString(display.text!) {
                return value.doubleValue
            }
            return nil
        }
        
        set {
            if let v = newValue {
                display.text = "\(v)"
            } else {
                display.text = "ERROR"
            }
        }
    }
    @IBAction func operate(sender: UIButton) {
        if isUserTyping {
            enterPress()
        }
        
        if let operation = sender.currentTitle {
            displayValue = brain.performOperation(operation)
            historyLabel.text = brain.history()
        }
        
    }
   
    
    @IBAction func enterPress() {
        isUserTyping = false
        isNumberADecimal = false
        if let v = displayValue {
            brain.pushValue(v)
        }
        displayValue = 0
        historyLabel.text = brain.history()
    }
    
    
    
    @IBAction func numberPress(sender: UIButton) {
        let number = sender.titleLabel!.text!;
        
        if (isUserTyping) {
            display.text = display.text! + number;
        } else {
            display.text = number;
            isUserTyping = true;
        }
    }
    @IBAction func Clear(sender: AnyObject) {
        historyLabel.text = ""
        displayValue = 0
        isUserTyping = false
        isNumberADecimal = false;
        brain.clear()
    }
    
    @IBAction func dotPress() {
        if !isNumberADecimal {
        if (isUserTyping) {
            display.text = display.text! + ",";
        } else {
            display.text = "0,";
        }
            isUserTyping = true;
        }
        isNumberADecimal = true;
    }
}

