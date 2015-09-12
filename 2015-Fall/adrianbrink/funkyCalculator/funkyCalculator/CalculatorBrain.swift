//
//  CalculatorBrain.swift
//  funkyCalculator
//
//  Created by aevitas on 12/09/15.
//  Copyright (c) 2015 aevitas. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)   // (The symbol, the function with one argument of Double)
        case BinaryOperation(String, (Double, Double) -> Double)    // The symbol, the function with two arguments
    }
    
    private var opStack = [Op]()    // = Array<Op>()
    
    private var knownOps = [String:Op]()    // = Dictionary<String, Op>()
    
    init() {    // called by 'let brain = CalculatorBrain()', looks for matching arguments. So init() is called by CalculatorBrain()
        knownOps["×"] = Op.BinaryOperation("×", *)  // { $0 * $1 }
        knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
        knownOps["+"] = Op.BinaryOperation("+", +)  // { $0 + $1 }
        knownOps["−"] = Op.BinaryOperation("−") { $1 - $0 }
        knownOps["√"] = Op.UnaryOperation("√", sqrt)    // { sqrt($0) }
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps:[Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):     // CalculatorBrain.Op.Operand() In the brackets I will tell what to do with the value of it is actually an Operand. let operand is a local variable only for this case
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation): // Ignores the value that was replaced by _
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack) // result and remainder refer to result and remainingOps in the private evaluate // let (result, _) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
}