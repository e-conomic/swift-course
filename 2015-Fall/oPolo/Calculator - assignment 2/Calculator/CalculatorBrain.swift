//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jonas Bruun Jacobsen on 15/09/15.
//  Copyright (c) 2015 Jonas Bruun Jacobsen. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case Constant(String, Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        case Variable(String)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .Constant(let constant, _):
                    return constant
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .Variable(let variable):
                    return variable
                }
            }
        }
    }
    
    let calculationQueueChangedFunctionName = "QueuedCalculationsChanged"
    private var opStack = [Op]() {
        didSet {
            //Fires a notification when a new operand/operator/constant/etc is added to the stack.
            NSNotificationCenter.defaultCenter().postNotificationName(calculationQueueChangedFunctionName, object: nil)
        }
    }
    
    
    private var knownOps = [String:Op]()
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.Constant("π", M_PI))
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷") { $1 / $0})
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−") { $1 - $0})
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .Variable(let variable):
                return (variableValues[variable], remainingOps)
            case .Constant(_, let constantValue):
                return (constantValue, remainingOps)
            case .UnaryOperation(_, let operation):
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
    
    
    var description : String {
        get {
            var (returnedDescription, remainingOps) = createDescription(opStack)
            while !(remainingOps.isEmpty) {
                var stackDescription : String
                (stackDescription, remainingOps) = createDescription(remainingOps)
                returnedDescription =  stackDescription + ", " + returnedDescription
            }
        return returnedDescription
        }
    }
    
    private func createDescription(ops: [Op]) -> (description: String, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return ("\(operand)", remainingOps)
            case .Variable(let variable):
                return (variable, remainingOps)
            case .Constant(let constant, _):
                return (constant, remainingOps)
            case .UnaryOperation(let symbol, _):
                let operandEvaluation = createDescription(remainingOps)
                return (symbol + "(" + operandEvaluation.description + ")" , operandEvaluation.remainingOps)
            case .BinaryOperation(let operation, _):
                var op1 = createDescription(remainingOps)
                var op2 = createDescription(op1.remainingOps)
                if (op2.description == "?") {
                    /*
                    This is purely a cosmetix fix. The reason is that if a user only types 
                    '2 'enter' '-' for example, then without the fix, it would be parsed
                    as: "?-2", whereas the user most likely meant "2-?" due to the order he typed it in.
                    Of course, both "?-2" and "2-?" evaluates to something NaN, but the fix still makes
                    it seem nicer.
                    */
                    op2.description = op1.description
                    op1.description = "?"
                }
                var returnedDescription = op2.description + operation + op1.description
                if (operation == "+" || operation == "-") {
                    //This is a bit of a cheasy way of adding parentheses but...
                    //Pretty much only "-" and "+" has a lower operator precedence
                    //than "*" and "/", if we do not count the logical operators.
                    //With such a limited amount of operators to have to guard with parentheses,
                    //I did not want to make anything really extensible and large for it... This is an easy way to solve it,
                    //although it does not scale as well, and is not perfect.
                    returnedDescription = "(" + returnedDescription + ")"
                }
                return (returnedDescription, op2.remainingOps)
            }
        }
        else {
            return ("?", ops);
        }
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func pushOperand(symbol: String) -> Double? {
        opStack.append(Op.Variable(symbol))
        return evaluate()
    }
    
    func resetCalculator() {
        opStack.removeAll()
        variableValues.removeAll()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}