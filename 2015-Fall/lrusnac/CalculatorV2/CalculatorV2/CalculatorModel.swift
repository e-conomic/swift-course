//
//  CalculatorModel.swift
//  CalculatorV2
//
//  Created by Leonid Rusnac on 08/09/15.
//  Copyright (c) 2015 Leonid Rusnac. All rights reserved.
//

import Foundation

class CalculatorModel {

    private enum Op: CustomStringConvertible{
        case Operand(Double)
        case UnaryOperator(String, Double -> Double)
        case BinaryOperator(String, (Double, Double) -> Double)
        case Constant(String, Double)
        
        // equivalent of toString in java
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperator(let operatorSymbol, _):
                    return operatorSymbol
                case .BinaryOperator(let operatorSymbol, _):
                    return operatorSymbol
                case .Constant(let operatorSymbol, _):
                    return operatorSymbol
                }
            }
        }
    }
    
    private var ops = [Op]()
    private var knownOps = [String:Op]()
    
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperator("+", +))
        learnOp(Op.BinaryOperator("×", *))
        learnOp(Op.BinaryOperator("÷", {$1/$0}))
        learnOp(Op.BinaryOperator("-", {$1-$0}))
        
        learnOp(Op.UnaryOperator("√", sqrt))
        learnOp(Op.UnaryOperator("sin", sin))
        learnOp(Op.UnaryOperator("cos", cos))
        
        learnOp(Op.Constant("π", M_PI))
    }
    
    var program: AnyObject {
        get {
            return ops.map { $0.description }
        }
        set {
            
        }
    }
    
    func pushNumber(number: Double) {
        ops.append(Op.Operand(number))
    }
    
    func pushOpNotNumber(keyString: String) {
        if let con = knownOps[keyString] {
            ops.append(con)
        }
    }
    
    func clear() {
        ops.removeAll(keepCapacity: false)
    }
    
    func evaluate() -> Double? {
        let (result, reminder) = evaluate(ops)
        print("\(ops) = \(result) with \(reminder)")
        return result
    }
    
    private func evaluate(stack: [Op]) -> (result: Double?, residualStack: [Op]) {
        if !stack.isEmpty {
            var reminderOps = stack
            let op = reminderOps.removeLast()
            
            switch op {
            case .Operand(let value):
                return (value, reminderOps)
            case .Constant(_, let value):
                return (value, reminderOps)
            case .UnaryOperator(_, let operatorFunc):
                let (result, residualStack) = evaluate(reminderOps)
                if let res = result {
                    return (operatorFunc(res), residualStack)
                }
            case .BinaryOperator(_, let operatorFunc):
                let (result, residualStack) = evaluate(reminderOps)
                if let leftResult = result {
                    let (result, residualStack) = evaluate(residualStack)
                    if let rightResult = result {
                        return (operatorFunc(leftResult, rightResult), residualStack)
                    }
                }
            }
        }
        return (nil, stack)
    }
    
    
    
}