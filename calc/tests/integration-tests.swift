//
//  integration-tests.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

func runIntegrationTests() {
    testValidInputs()
    testInvalidInputs()
}

private func testValidInputs() {
    let validInputsAndNumbers: [String: Number] = [
        "0": .int(0),
        "0.0": .double(0.0),
        "1": .int(1),
        "1.0": .double(1.0),
        "-1": .int(-1),
        "-1.0": .double(-1.0),
        "(1)": .int(1),
        "(1.0)": .double(1.0),
        "-(1)": .int(-1),
        "-(1.0)": .double(-1.0),
        "(-1)": .int(-1),
        "(-1.0)": .double(-1.0),
        "1 + 2": .int(3),
        "1 + 2.0": .double(3.0),
        "1 - 2": .int(-1),
        "1.0 - 2": .double(-1),
        "1 * 2": .int(2),
        "1 * -2": .int(-2),
        "1 * -2 / 2": .double(-1.0),
        "1 / 1": .double(1.0),
        "1 / 2": .double(0.5),
        "1 / 2.0": .double(0.5),
        "1 + 2 * 3 / 4": .double(2.5),
        "(1 + 2) * (3 / 4)": .double(2.25),
        "(1 + 2) * ((3 * 3 - 1) / 4)": .double(6.0),
        "-(1 + 2) * ((3 * 3 - 1) / 4)": .double(-6.0),
        "4 * 0.5": .double(2.0),
        "4*-.5": .double(-2.0),
        ]
    for (input, expectedNumber) in validInputsAndNumbers {
        switch calculate(input) {
        case .error(let error):
            print("Error for input: " + input)
            assertionFailure(error.localizedDescription)
        case .value(let actualNumber):
            if expectedNumber != actualNumber {
                print("Expected: \(expectedNumber) Actual: \(actualNumber)")
                assertionFailure("Wrong result for input: " + input)
            }
        }
    }
}

private func testInvalidInputs() {
    let invalidInputsAndCalcErrors: [String: CalcError] = [
        "": .cannotProcessEmptyExpression,
        "A": .unexpectedCharacter(at: 0),
        "+": .cannotProcessSingleOperator,
        "*": .cannotProcessSingleOperator,
        "/": .cannotProcessSingleOperator,
        "-": .malformedInput, // It's assumed to be a negation operator.
        "+42": .invalidOperationCount, // Unary plus is not supported.
        "--42": .malformedInput,
        "1 + 2.0.0": .multipleDecimalSeparators,
        "(1 + 2))": .missingLeftParenthesis,
        "((1 + 2)": .missingRightParenthesis,
        "1.0 + 2.0 * ": .invalidOperationCount,
        "42 / (1 - 1)": .divideByZero
        ]
    for (input, expectedError) in invalidInputsAndCalcErrors {
        switch calculate(input) {
        case .error(let actualError):
            if expectedError != actualError {
                print(actualError.message)
                assertionFailure("Wrong error for input: " + input)
            }
        case .value:
            assertionFailure("Invalid input should have failed: " + input)
        }
    }
}
