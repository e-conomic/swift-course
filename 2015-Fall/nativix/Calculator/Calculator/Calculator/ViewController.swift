//
//  ViewController.swift
//  Calculator
//
//  Created by MARIA NATIVIDAD LARA DIAZ on 01/09/15.
//  Copyright (c) 2015 Appstract Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
   
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    var numberStack = [Double]()
    var symbolStack = [String]()
    
    @IBAction func operate(sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = false
        numberStack.append((display.text! as NSString).doubleValue)
        println("numberStack = \(numberStack)")
        if symbolStack.count >= 1 && numberStack.count >= 1 {
            let operation = symbolStack.removeLast()
            switch operation {
            case "+" : performOperation{ $0 + $1}
            case "×" : performOperation{ $0 * $1}
            case "−" : performOperation{ $1 - $0}
            case "÷" : performOperation{ $1 / $0}
            case "√" : performOperation1{sqrt($0)}
            case "=" : performOperation1{$0}
            default: break
            }
        }
        symbolStack.append(sender.currentTitle!)
        println("symbolStack = \(symbolStack)")
    }
    
    func performOperation(operation: (Double,Double) -> Double){
        if numberStack.count >= 2 {
            displayValue = operation(numberStack.removeLast(),numberStack.removeLast())
            numberStack.append((display.text! as NSString).doubleValue)//Append the result to the stack in order to do more operations
        }
    }
    
    func performOperation1(operation: Double -> Double){
        if numberStack.count >= 1 {
            displayValue = operation(numberStack.removeLast())
            numberStack.append((display.text! as NSString).doubleValue)
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

    
    @IBAction func restart(sender: UIButton) {
        numberStack.removeAll()
        symbolStack.removeAll()
        displayValue = 0
    }
}

