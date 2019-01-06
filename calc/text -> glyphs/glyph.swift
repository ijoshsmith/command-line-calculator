//
//  glyph.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// A single piece of text.
enum Glyph: Equatable, CustomDebugStringConvertible {

    case add
    case decimalSeparator
    case digit(UnicodeScalar)
    case divide
    case multiply
    case parenthesisLeft
    case parenthesisRight
    case subtractOrNegate
    case whitespace

    var debugDescription: String {
        switch self {
        case .add:               return "+"
        case .decimalSeparator:  return "."
        case .digit(let scalar): return String(scalar)
        case .divide:            return "/"
        case .multiply:          return "*"
        case .parenthesisLeft:   return "("
        case .parenthesisRight:  return ")"
        case .subtractOrNegate:  return "-"
        case .whitespace:        return " "
        }
    }

}
