//
//  calculator.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// Produces a number by evaluating an expression.
enum Calculator {

    static func evaluate(expression: Expression) -> CalcResult<Number> {
        do {
            let number = try expression.evaluate()
            return .value(number)
        }
        catch let calcError as CalcError {
            return .error(calcError)
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }

}

private extension Expression {

    func evaluate() throws -> Number {
        switch self {
        case .empty:                      fatalError()
        case .number(let number):         return number
        case .add(     let lhs, let rhs): return try lhs.evaluate() + rhs.evaluate()
        case .divide(  let lhs, let rhs): return try Expression.divide(lhs, by: rhs)
        case .multiply(let lhs, let rhs): return try lhs.evaluate() * rhs.evaluate()
        case .subtract(let lhs, let rhs): return try lhs.evaluate() - rhs.evaluate()
        }
    }

    private static func divide(_ left: Expression, by right: Expression) throws -> Number {
        let dividend = try left.evaluate()
        let divisor  = try right.evaluate()
        guard divisor.isZero == false else {
            throw CalcError.divideByZero
        }
        return dividend / divisor
    }

}

private extension Number {

    var isZero: Bool {
        switch self {
        case .double(let doubleValue): return doubleValue.isZero
        case .int(let intValue):       return intValue == 0
        }
    }

    static func +(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.int(i),    .int(ii)):    return .int(i + ii)
        case let (.int(i),    .double(d)):  return .double(Double(i) + d)
        case let (.double(d), .int(i)):     return .double(d + Double(i))
        case let (.double(d), .double(dd)): return .double(d + dd)
        }
    }

    static func /(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        // Always use doubles when dividing to avoid accuracy loss.
        case let (.int(i),    .int(ii)):    return .double(Double(i) / Double(ii))
        case let (.int(i),    .double(d)):  return .double(Double(i) / d)
        case let (.double(d), .int(i)):     return .double(d / Double(i))
        case let (.double(d), .double(dd)): return .double(d / dd)
        }
    }

    static func *(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.int(i),    .int(ii)):    return .int(i * ii)
        case let (.int(i),    .double(d)):  return .double(Double(i) * d)
        case let (.double(d), .int(i)):     return .double(d * Double(i))
        case let (.double(d), .double(dd)): return .double(d * dd)
        }
    }

    static func -(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.int(i),    .int(ii)):    return .int(i - ii)
        case let (.int(i),    .double(d)):  return .double(Double(i) - d)
        case let (.double(d), .int(i)):     return .double(d - Double(i))
        case let (.double(d), .double(dd)): return .double(d - dd)
        }
    }

}
