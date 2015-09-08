//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Martin Hartvig on 08/09/15.
//  Copyright (c) 2015 Martin Hartvig. All rights reserved.
//

import Foundation


class CalculatorBrian {
    
    private enum Ops: Printable {
        case value(Double)
        case MathConst(String, Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .value(let value):
                    return "\(value)"
                case .UnaryOperation(let symbol, _):
                    return "\(symbol)"
                case .BinaryOperation(let symbol, _):
                    return "\(symbol)"
                case .MathConst(let symbol, _):
                    return "\(symbol)"
                }
            }
        }
    }
    private var opStack = [Ops]()
    
    private var knownOps = [String:Ops]()
    
    init() {
        func learn(op: Ops) {
            knownOps[op.description] = op
        }
    
        learn(Ops.BinaryOperation("+", +))
        learn(Ops.BinaryOperation("−") {$1 - $0})
        learn(Ops.BinaryOperation("×", *))
        learn(Ops.BinaryOperation("÷") {$1 / $0})
        learn(Ops.UnaryOperation("√", sqrt))
        learn(Ops.MathConst("π", M_PI ))
    }
    
    func pushValue(value: Double) {
        opStack.append(Ops.value(value))
    }
    
    func performOperation(action: String) -> Double? {
        if let operation = knownOps[action] {
            opStack.append(operation);
        }
        return evaluate()
    }
    
    func history() -> String {
        return "\(opStack)"
    }
    
    func evaluate() -> Double? {
        let (result, reminder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(reminder)")
        return result
    }
    
    func clear() {
        opStack = [Ops]()
    }
    
    private func evaluate(ops: [Ops]) -> (Result: Double?, ReminderOps: [Ops]) {
        
        if (!ops.isEmpty) {
            var reminderOps = ops
            let op = reminderOps.removeLast()
            
            switch op {
            case .value(let value):
                return (value, reminderOps)
            case .MathConst(_,let value):
                return (value, reminderOps)
            case .UnaryOperation(_, let operation):
                let evaluatedOp = evaluate(reminderOps)
                if let res = evaluatedOp.Result {
                    return (operation(res), evaluatedOp.ReminderOps)
                }
            case .BinaryOperation(_, let operation):
                let leftEvaluation = evaluate(reminderOps)
                if let leftResult = leftEvaluation.Result {
                    let rightEvaluation = evaluate(leftEvaluation.ReminderOps)
                    if let rightResult = rightEvaluation.Result {
                        return (operation(leftResult,rightResult), rightEvaluation.ReminderOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
}
