//
//  CalculaterBrain.swift
//  Calculater
//
//  Created by Søren Dalby on 13/09/15.
//  Copyright (c) 2015 Søren Dalby. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    enum Operation {
        case Plus
        case Minus
        case Divide
        case Subtract
        case Multiply
        case Sqrt
    }
    private enum Op {
        case Operand(Double)
        case UnaryOperation(Operation, Double -> Double)
        case BinaryOperation(Operation, (Double, Double) -> Double)
    }
    
    
    
    private var opStack = [Op]()
    private var knownOps = [Operation: Op]()
    
    init() {
        knownOps[.Multiply] = Op.BinaryOperation(.Multiply, *)
        knownOps[.Divide] = Op.BinaryOperation(.Divide) { $1 / $0 }
        knownOps[.Minus] = Op.BinaryOperation(.Minus) { $0 - $1 }
        knownOps[.Plus] = Op.BinaryOperation(.Plus, +)
        knownOps[.Sqrt] = Op.UnaryOperation(.Sqrt, sqrt)
        
    }
    
    // IMPORTANT: ops is an array and is derived from struct, thus it is passed by value and is immutable (implicit 'let' in front)
    // by explicitly declaring it as a var, we make it muteable but it is still passed by value
    // finally by copying int to a var in the function body does the same trick
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        if(!ops.isEmpty) {
            var remainingOps = ops;
            let op = remainingOps.removeLast();
            
            switch op {
            case .Operand(let operand):
                return(operand, remainingOps)
            case .UnaryOperation(_, let operation): // _ means unused variabel
                let operationEvaluation = evaluate(remainingOps)
                if let operand = operationEvaluation.result {
                    return (operation(operand), operationEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    
                    let op2Evaluation = evaluate(remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
                
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack) // implicit declared tuple with unused variable

    
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
        
    }
    
    func performOperation(symbol: Operation) -> Double? {
        let operation = knownOps[symbol]!
        opStack.append(operation)
        return evaluate()
    }
    
}