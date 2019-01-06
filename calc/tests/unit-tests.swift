//
//  unit-tests.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

func runUnitTests() {
    CalcUnitTest(
        input: "1 + 2 * 3",
        glyphs: [
            .digit("1"),
            .whitespace,
            .add,
            .whitespace,
            .digit("2"),
            .whitespace,
            .multiply,
            .whitespace,
            .digit("3")],
        tokens: [
            .number(.int(1)),
            .add,
            .number(.int(2)),
            .multiply,
            .number(.int(3))],
        operations: [
            .operand(.number(.int(1))),
            .binaryOperator(.add),
            .operand(.number(.int(2))),
            .binaryOperator(.multiply),
            .operand(.number(.int(3)))],
        expression:
        .add(
            .number(.int(1)),
            .multiply(.number(.int(2)),
                      .number(.int(3)))),
        result: .value(.int(7)))
        .runUnitTests()

    CalcUnitTest(
        input: "(1 + 2) * 3",
        glyphs: [
            .parenthesisLeft,
            .digit("1"),
            .whitespace,
            .add,
            .whitespace,
            .digit("2"),
            .parenthesisRight,
            .whitespace,
            .multiply,
            .whitespace,
            .digit("3")],
        tokens: [
            .parenthesisLeft(negated: false),
            .number(.int(1)),
            .add,
            .number(.int(2)),
            .parenthesisRight,
            .multiply,
            .number(.int(3))],
        operations: [
            .operand(.parenthesizedOperations([
                .operand(.number(.int(1))),
                .binaryOperator(.add),
                .operand(.number(.int(2)))
                ], negated: false)),
            .binaryOperator(.multiply),
            .operand(.number(.int(3)))],
        expression:
        .multiply(
            .add(.number(.int(1)),
                 .number(.int(2))),
            .number(.int(3))),
        result: .value(.int(9)))
        .runUnitTests()

    CalcUnitTest(
        input: "(1 + 2) * 3 - -4.0",
        glyphs: [
            .parenthesisLeft,
            .digit("1"),
            .whitespace,
            .add,
            .whitespace,
            .digit("2"),
            .parenthesisRight,
            .whitespace,
            .multiply,
            .whitespace,
            .digit("3"),
            .whitespace,
            .subtractOrNegate,
            .whitespace,
            .subtractOrNegate,
            .digit("4"),
            .decimalSeparator,
            .digit("0")],
        tokens: [
            .parenthesisLeft(negated: false),
            .number(.int(1)),
            .add,
            .number(.int(2)),
            .parenthesisRight,
            .multiply,
            .number(.int(3)),
            .subtract,
            .number(.double(-4.0))],
        operations: [
            .operand(.parenthesizedOperations([
                .operand(.number(.int(1))),
                .binaryOperator(.add),
                .operand(.number(.int(2)))
                ], negated: false)),
            .binaryOperator(.multiply),
            .operand(.number(.int(3))),
            .binaryOperator(.subtract),
            .operand(.number(.double(-4.0)))],
        expression:
        .subtract(
            .multiply(
                .add(.number(.int(1)),
                     .number(.int(2))),
                .number(.int(3))),
            .number(.double(-4.0))),
        result: .value(.double(13.0)))
        .runUnitTests()

    CalcUnitTest(
        input: "1 + 2 x (4 - 3.0) / -2",
        glyphs: [
            .digit("1"),
            .whitespace,
            .add,
            .whitespace,
            .digit("2"),
            .whitespace,
            .multiply,
            .whitespace,
            .parenthesisLeft,
            .digit("4"),
            .whitespace,
            .subtractOrNegate,
            .whitespace,
            .digit("3"),
            .decimalSeparator,
            .digit("0"),
            .parenthesisRight,
            .whitespace,
            .divide,
            .whitespace,
            .subtractOrNegate,
            .digit("2")],
        tokens: [
            .number(.int(1)),
            .add,
            .number(.int(2)),
            .multiply,
            .parenthesisLeft(negated: false),
            .number(.int(4)),
            .subtract,
            .number(.double(3.0)),
            .parenthesisRight,
            .divide,
            .number(.int(-2))],
        operations: [
            .operand(.number(.int(1))),
            .binaryOperator(.add),
            .operand(.number(.int(2))),
            .binaryOperator(.multiply),
            .operand(.parenthesizedOperations([
                .operand(.number(.int(4))),
                .binaryOperator(.subtract),
                .operand(.number(.double(3.0)))
                ], negated: false)),
            .binaryOperator(.divide),
            .operand(.number(.int(-2)))],
        expression:
        .add(
            .number(.int(1)),
            .divide(
                .multiply(
                    .number(.int(2)),
                    .subtract(
                        .number(.int(4)),
                        .number(.double(3.0)))),
                .number(.int(-2)))),
        result: .value(.double(0.0)))
        .runUnitTests()
}
