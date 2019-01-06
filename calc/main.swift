//
//  main.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

let isTesting = true

func calculate(_ input: String) -> CalcResult<Number> {
    return InputParser.createGlyphs(from: input)
        .then(Tokenizer.createTokens(fromGlyphs:))
        .then(Operationizer.createOperations(fromTokens:))
        .then(Expressionizer.createExpression(fromOperations:))
        .then(Calculator.evaluate(expression:))
}

let input: String
if isTesting {
    input = "1 + 2 * -3 + 4 * (5 + 6) + -(7 - 8) + 9 / 10 + 1.1"
}
else {
    input = CommandLine.arguments.dropFirst().joined(separator: " ")
}

switch calculate(input) {
case .value(let number): print(number)
case .error(let error):  print(error.message)
}

if isTesting {
    runUnitTests()
    print("Unit tests passed.")
    runIntegrationTests()
    print("Integration tests passed.")
}
