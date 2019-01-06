//
//  calc-unit-test.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

struct CalcUnitTest {
    let input: String
    let glyphs: [Glyph]
    let tokens: [Token]
    let operations: [Operation]
    let expression: Expression
    let result: CalcResult<Number>

    func runUnitTests() {
        testInputParser()
        testTokenizer()
        testOperationizer()
        testExpressionizer()
        testCalculator()
    }

    private func testInputParser() {
        switch InputParser.createGlyphs(from: input) {
        case .value(let actual):
            if actual != glyphs {
                print("Expected: \(glyphs)\nActual:   \(actual)")
                assertionFailure("InputParser test failed.")
            }
        case .error(let error):
            assertionFailure("InputParser error: " + error.message)
        }
    }

    private func testTokenizer() {
        switch Tokenizer.createTokens(fromGlyphs: glyphs) {
        case .value(let actual):
            if actual != tokens {
                print("Expected:")
                dump(tokens)
                print("Actual:")
                dump(actual)
                assertionFailure("Tokenizer test failed.")
            }
        case .error(let error):
            assertionFailure("Tokenizer error: " + error.message)
        }
    }

    private func testOperationizer() {
        switch Operationizer.createOperations(fromTokens: tokens) {
        case .value(let actual):
            if actual != operations {
                print("Expected:")
                dump(operations)
                print("Actual:")
                dump(actual)
                assertionFailure("Operationizer test failed.")
            }
        case .error(let error):
            assertionFailure("Operationizer error: " + error.message)
        }
    }

    private func testExpressionizer() {
        switch Expressionizer.createExpression(fromOperations: operations) {
        case .value(let actual):
            if actual != expression {
                print("Expected:")
                dump(expression)
                print("Actual:")
                dump(actual)
                assertionFailure("Expressionizer test failed.")
            }
        case .error(let error):
            assertionFailure("Expressionizer error: " + error.message)
        }
    }

    private func testCalculator() {
        let actual = Calculator.evaluate(expression: expression)
        if actual != result {
            print("Expected:")
            dump(result)
            print("Actual:")
            dump(actual)
            assertionFailure("Calculator test failed.")
        }
    }

}
