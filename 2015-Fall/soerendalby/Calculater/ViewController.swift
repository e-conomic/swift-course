//
//  ViewController.swift
//  Calculater
//
//  Created by Søren Dalby on 06/09/15.
//  Copyright (c) 2015 Søren Dalby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var display: UILabel!

    var continueCurrentNumber = false
    var calculaterBrain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(continueCurrentNumber) {
            display.text = display.text! +   digit
        } else {
            display.text = digit
            continueCurrentNumber = true
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!;
        
        if continueCurrentNumber {
            enter();
        }
        
        var result:Double?;
        
        switch operation {
    
        case "x":
            result = calculaterBrain.performOperation(CalculatorBrain.Operation.Multiply)
        case "/":
            result = calculaterBrain.performOperation(CalculatorBrain.Operation.Divide)
        case "+":
            result = calculaterBrain.performOperation(CalculatorBrain.Operation.Plus)
        case "-":
            result = calculaterBrain.performOperation(CalculatorBrain.Operation.Minus)
        default:
            // should cause fatal error
            break;
        }
        if result != nil {
            displayValue = result!;
        } else {
            displayValue = 0;
        }
    }
    
    @IBAction func enter() {
        continueCurrentNumber = false;
        if let result = calculaterBrain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0;
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

