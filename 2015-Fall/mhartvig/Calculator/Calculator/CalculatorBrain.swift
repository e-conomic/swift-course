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
        case UnaryOperation(Symbol, Double -> Double)
        case BinaryOperation(Symbol, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .value(let value):
                        return "\(value)"
                case .UnaryOperation(let symbol, _):
                        return "\(symbol)"
                case .BinaryOperation(let symbol, _):
                        return "\(symbol)"
                }
            }
        }
    }
    
    enum Symbol: Character {
        case Addition = "+"
        case Minus = "−"
        case Multiplication = "×"
        case Divition = "÷"
        case Sqrt = "√"
    }
    
    private var opStack = [Ops]()
    
    private var knownOps = [Symbol:Ops]()
    
    init() {
        knownOps[Symbol.Addition] = Ops.BinaryOperation(Symbol.Addition, +)
        knownOps[Symbol.Minus] = Ops.BinaryOperation(Symbol.Minus, -)
        knownOps[Symbol.Multiplication] = Ops.BinaryOperation(Symbol.Multiplication, *)
        knownOps[Symbol.Divition] = Ops.BinaryOperation(Symbol.Divition, /)
        knownOps[Symbol.Sqrt] = Ops.UnaryOperation(Symbol.Sqrt, sqrt)
    }
    
    func pushValue(value: Double) {
        opStack.append(Ops.value(value))
    }
    
    func performOperation(symbol: Symbol) {
        if let operation = knownOps[symbol] {
            opStack.append(operation);
        }
    }
    
    func evaluate() -> Double? {
        let eva = evaluate(opStack)
        return eva.Result
    }
    
    private func evaluate(ops: [Ops]) -> (Result: Double?, ReminderOps: [Ops]) {
        
        if (!ops.isEmpty) {
            var reminderOps = ops
            let op = reminderOps.removeLast()
            
            switch op {
            case .value(let value):
                return (value, reminderOps)
            case .UnaryOperation(_, let operation):
                let evaluatedOp = evaluate(reminderOps)
                if let res = evaluatedOp.Result {
                    return (operation(res), evaluatedOp.ReminderOps)
                }
            case .BinaryOperation(_, let operation):
                let eva1 = evaluate(reminderOps)
                if let value1 = eva1.Result {
                    let eva2 = evaluate(eva1.ReminderOps)
                    if let value2 = eva2.Result {
                        return (operation(value1,value2), eva2.ReminderOps)
                    }
                    
                }
            }
            
        }
        return (nil, ops)
    }
}
