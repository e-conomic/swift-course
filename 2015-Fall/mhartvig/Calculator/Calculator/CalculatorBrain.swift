//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Martin Hartvig on 08/09/15.
//  Copyright (c) 2015 Martin Hartvig. All rights reserved.
//

import Foundation


class CalculatorBrian {
    
    private enum Ops: CustomStringConvertible {
        case value(Double)
        case MathConst(String, Double)
        case Variable(String)
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
                case .Variable(let variable):
                    return variable
                }
            }
        }
    }
    
    var description: String {
        get {
            if let desc = evalDescription() {
                return desc
            }
            return ""
        }
    }
    
    private var opStack = [Ops]()
    
    private var knownOps = [String:Ops]()
    
    private var variables = [String:Double]()
    
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
    
    func clear() {
        opStack = [Ops]()
        variables = [String:Double]()
    }
    
    func pushOperand(symbol: String) -> Double? {
        opStack.append(Ops.Variable(symbol))
        return evaluate()
    }
    
    func setVariable(symbol: String, value: Double) {
        variables[symbol] = value
    }
    
    func getVariable(symbol: String) -> Double? {
        return variables[symbol]
    }
    
    private func evalDescription() -> String? {
        let (result, _) = description(opStack)
        print(result)
        return result
    }
    
    private func description(ops: [Ops]) -> (Result: String?, ReminderOps: [Ops]) {
        if (!ops.isEmpty) {
            var reminderOps = ops
            let op = reminderOps.removeLast()
            
            switch op {
            case .value(let value):
                return ("\(value)", reminderOps)
            case .MathConst(let symbol, _):
                return ("\(symbol)", reminderOps)
            case .Variable(let variable):
                return ("\(variable)", reminderOps)
            case .UnaryOperation(let symbol, _):
                let evaluatedOp = description(reminderOps)
                if let res = evaluatedOp.Result {
                    return ("\(symbol)(\(res))", evaluatedOp.ReminderOps)
                }
            case .BinaryOperation(let symbol,_):
                let leftEvaluation = description(reminderOps)
                if let leftResult = leftEvaluation.Result {
                    let rightEvaluation = description(leftEvaluation.ReminderOps)
                    if let rightResult = rightEvaluation.Result {
                        return ("\(rightResult)\(symbol)\(leftResult)", rightEvaluation.ReminderOps)
                    }
                }
            }
        }
        return ("?", ops)
    }
    
    
    func evaluate() -> Double? {
        let (result, reminder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(reminder)")
        return result
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
            case .Variable(let variable):
                if let value = variables[variable] {
                    return (value, reminderOps)
                }
                return (nil, ops)
            }
        }
        return (nil, ops)
    }
}
