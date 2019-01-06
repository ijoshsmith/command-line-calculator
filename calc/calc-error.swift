//
//  calc-error.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// All errors that can be thrown by the calculation pipeline.
enum CalcError: Error, Equatable {

    case cannotProcessEmptyExpression
    case cannotProcessSingleOperator
    case divideByZero
    case invalidOperationCount
    case malformedInput
    case missingLeftOperand
    case missingLeftParenthesis
    case missingOperator
    case missingRightOperand
    case missingRightParenthesis
    case multipleDecimalSeparators
    case unexpectedCharacter(at: Int)

    var message: String {
        switch self {
        case .cannotProcessEmptyExpression:      return "Cannot process empty expression."
        case .cannotProcessSingleOperator:       return "Cannot process only an operator."
        case .divideByZero:                      return "Division by zero is not allowed."
        case .invalidOperationCount:             return "Insufficient number of operators/operands."
        case .malformedInput:                    return "Malformed input."
        case .missingLeftOperand:                return "Missing a left operand."
        case .missingLeftParenthesis:            return "There is an unmatched )."
        case .missingOperator:                   return "Missing an operator."
        case .missingRightOperand:               return "Missing a right operand."
        case .missingRightParenthesis:           return "There is an unmatched (."
        case .multipleDecimalSeparators:         return "Number cannot have multiple decimal separators."
        case .unexpectedCharacter(let position): return "Unexpected character at position \(position)."
        }
    }
}
