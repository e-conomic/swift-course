//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by MARIA NATIVIDAD LARA DIAZ on 05/10/15.
//  Copyright © 2015 Appstract Development. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    
    var symbolStack = [String]()
    var numberStack = [Double]()
    
    func pushNumber(number: Double){
        numberStack.append(number)
    }
    
    func pushSymbol(symbol: String){
        symbolStack.append(symbol)
    }
    
    func performBinaryOperation() -> (Double?){
        if numberStack.count >= 2 {
            let n2 = numberStack.removeLast()
            let n1 = numberStack.removeLast()
            let operation = symbolStack.removeLast()
            switch operation {
            case "+" : return (n1 + n2)
            case "×" : return (n1 * n2)
            case "−" : return (n1 - n2)
            case "÷" : return (n1 / n2)
            default: break
            }
        }
        return nil
    }
    
    func performUnaryOperation() -> (Double?)
        {
        if numberStack.count == 1 {
            let n1 = numberStack.removeLast()
            let operation = symbolStack.removeLast()
            switch operation {
            case "√" : return (sqrt(n1))
            case "cos" : return (cos(n1))
            case "sin" : return (sin(n1))
            case "∏" : return (M_PI*n1)
            default: break
            }
        }
        return nil
    }
    
    func clearDisplay(){
        symbolStack.removeAll()
        numberStack.removeAll()
    }
}