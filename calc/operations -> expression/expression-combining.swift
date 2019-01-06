//
//  expression-combining.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

extension Expression {

    /// Arranges the expressions into a tree honoring arithemtic's order of operations.
    static func combine(_ expressions: [Expression]) throws -> Expression {
        return try expressions.reduce(.empty, combine(current:withNext:))
    }

    private static func combine(current: Expression, withNext next: Expression) throws -> Expression {
        if case .empty = current { return next }
        guard
            let currentRightExpression = current.rightExpression,
            let currentPrecedence      = current.precedence,
            let nextPrecedence         = next.precedence
            else { throw CalcError.malformedInput }
        if currentPrecedence < nextPrecedence {
            let splicedRight = next.replacingLeftExpression(with: currentRightExpression)
            return current.replacingRightExpression(with: splicedRight)
        }
        else {
            return next.replacingLeftExpression(with: current)
        }
    }

    private var rightExpression: Expression? {
        switch self {
        case let .add(_,      right): return right
        case let .divide(_,   right): return right
        case let .multiply(_, right): return right
        case let .subtract(_, right): return right
        case .empty, .number:         return nil
        }
    }

    private func replacingLeftExpression(with left: Expression) -> Expression {
        switch self {
        case .add(     _, let right): return .add(     left, right)
        case .divide(  _, let right): return .divide(  left, right)
        case .multiply(_, let right): return .multiply(left, right)
        case .subtract(_, let right): return .subtract(left, right)
        case .empty, .number:         fatalError()
        }
    }

    private func replacingRightExpression(with right: Expression) -> Expression {
        switch self {
        case .add(     let left, _): return .add(     left, right)
        case .divide(  let left, _): return .divide(  left, right)
        case .multiply(let left, _): return .multiply(left, right)
        case .subtract(let left, _): return .subtract(left, right)
        case .empty, .number:        fatalError()
        }
    }

    private var precedence: Precedence? {
        switch self {
        case .add, .subtract:    return .addOrSubtract
        case .multiply, .divide: return .multiplyOrDivide
        case .empty, .number:    return nil
        }
    }

    private enum Precedence: Int, Comparable {
        case addOrSubtract, multiplyOrDivide
        static func < (lhs: Precedence, rhs: Precedence) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }

}
