//
//  operationizer.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// Creates nested arrays of operations by categorizing tokens.
final class Operationizer {

    static func createOperations(fromTokens tokens: [Token]) -> CalcResult<[Operation]> {
        let operationizer = Operationizer(tokenIterator: tokens.makeIterator())
        let operations = operationizer.createOperations()
        return .value(operations)
    }

    private init(tokenIterator: IndexingIterator<[Token]>) {
        self.tokenIterator = tokenIterator
    }

    private var tokenIterator: IndexingIterator<[Token]>

    private func createOperations() -> [Operation] {
        var operations = [Operation]()
        while let token = tokenIterator.next() {
            if let operation = createOperation(for: token) {
                operations.append(operation)
            }
            else {
                return operations
            }
        }
        return operations
    }

    private func createOperation(for token: Token) -> Operation? {
        switch token {
        case .add:                return .binaryOperator(.add)
        case .divide:             return .binaryOperator(.divide)
        case .multiply:           return .binaryOperator(.multiply)
        case .subtract:           return .binaryOperator(.subtract)
        case .number(let number): return .operand(.number(number))
        case .parenthesisLeft(let negated):
            let operations = createOperations()
            return .operand(.parenthesizedOperations(operations, negated: negated))
        case .parenthesisRight:
            return nil
        }
    }

}
