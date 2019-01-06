//
//  operation.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// A value represents either an operator or operand in a calculation.
indirect enum Operation: Equatable {

    case binaryOperator(BinaryOperator)
    enum BinaryOperator: Equatable {
        case add, divide, multiply, subtract
    }

    case operand(Operand)
    enum Operand: Equatable {
        case number(Number)
        case parenthesizedOperations([Operation], negated: Bool)
    }
    
}
