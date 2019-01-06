//
//  expressionizer.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// Builds a tree of expressions honoring arithmetic's order of operations.
final class Expressionizer {

    static func createExpression(fromOperations operations: [Operation]) -> CalcResult<Expression> {
        do {
            let expression = try createValidatedExpression(with: operations)
            return .value(expression)
        }
        catch let calcError as CalcError {
            return .error(calcError)
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }

    private static func createValidatedExpression(with operations: [Operation]) throws -> Expression {
        guard operations.isEmpty == false else {
            throw CalcError.cannotProcessEmptyExpression
        }
        guard operations.count > 1 else {
            switch operations[0] {
            case .binaryOperator:       throw CalcError.cannotProcessSingleOperator
            case .operand(let operand): return try createExpression(for: operand)
            }
        }
        guard operations.count % 2 == 1 else {
            throw CalcError.invalidOperationCount
        }
        let expressionizer = Expressionizer(operations: operations)
        let possibleExpressions = try expressionizer.createAllPossibleExpressions()
        let combinedExpression = try Expression.combine(possibleExpressions)
        return combinedExpression
    }

    private init(operations: [Operation]) {
        self.operations = operations
    }

    private let operations: [Operation]

    private func createAllPossibleExpressions() throws -> [Expression] {
        return try stride(from: 1, to: operations.count, by: 2).map { index in
            guard let leftOperand    = getOperand(at:  index - 1) else { throw CalcError.missingLeftOperand }
            guard let binaryOperator = getOperator(at: index)     else { throw CalcError.missingOperator }
            guard let rightOperand   = getOperand(at:  index + 1) else { throw CalcError.missingRightOperand }
            return try Expressionizer.createExpression(leftOperand, binaryOperator, rightOperand)
        }
    }

    private func getOperand(at index: Int) -> Operation.Operand? {
        guard operations.indices.contains(index) else { return nil }
        switch operations[index] {
        case .binaryOperator:  return nil
        case .operand(let op): return op
        }
    }

    private func getOperator(at index: Int) -> Operation.BinaryOperator? {
        guard operations.indices.contains(index) else { return nil }
        switch operations[index] {
        case .binaryOperator(let op): return op
        case .operand:                return nil
        }
    }

    private static func createExpression(_ leftOperand:    Operation.Operand,
                                         _ binaryOperator: Operation.BinaryOperator,
                                         _ rightOperand:   Operation.Operand) throws -> Expression {
        let leftExpression  = try createExpression(for: leftOperand)
        let rightExpression = try createExpression(for: rightOperand)
        switch binaryOperator {
        case .add:      return .add(     leftExpression, rightExpression)
        case .divide:   return .divide(  leftExpression, rightExpression)
        case .multiply: return .multiply(leftExpression, rightExpression)
        case .subtract: return .subtract(leftExpression, rightExpression)
        }
    }

    private static func createExpression(for operand: Operation.Operand) throws -> Expression {
        switch operand {
        case .number(let number):
            return Expression.number(number)
        case .parenthesizedOperations(let parenthesizedOperations, let negated):
            let expression = try createValidatedExpression(with: parenthesizedOperations)
            return negated ? expression.negated() : expression
        }
    }

}

private extension Expression {

    func negated() -> Expression {
        return .multiply(.number(.int(-1)), self)
    }

}
