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
    
    var isUserTyping: Bool = false;
    var isNumberADecimal: Bool = false;
    
    var lastOperation: String? = nil;
    var result: Double = 0;
    
    
    func resetDisplay() {
        display.text = "0";
        isUserTyping = false;
        isNumberADecimal = false;
    }
    
    func evaluateCalculation(number: Double, nextOperation: String?) {
        if (lastOperation == nil) {
            result = number;
        } else {
            switch lastOperation! {
                case "+":
                    result += number;
                case "-":
                    result -= number;
                case "*":
                    result *= number;
                case "/":
                    result /= number;
            default:
                break;
            }
        }
        
        let
        
        lastOperation = nextOperation;
    }
    
    @IBAction func actionPress(sender: UIButton) {
        let currentNumber = NSNumberFormatter().numberFromString(display.text!)?.doubleValue;
        evaluateCalculation(currentNumber!, nextOperation: sender.currentTitle!);
        resetDisplay();
        
    }
    
    @IBAction func equalPressed(sender: UIButton) {
        let currentNumber = NSNumberFormatter().numberFromString(display.text!)?.doubleValue;
        evaluateCalculation(currentNumber!, nextOperation: nil);
        isUserTyping = false;
        isNumberADecimal = false;
        display.text = result.description;
        
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
    
    @IBAction func dotPress(sender: UIButton) {
        if (isUserTyping) {
            display.text = display.text! + ",";
        } else {
            display.text = "0,";
        }
        isNumberADecimal = true;
        dotButton.enabled = false;
    }
}

