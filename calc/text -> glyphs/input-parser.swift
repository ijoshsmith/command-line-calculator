//
//  input-parser.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

import struct Foundation.CharacterSet

/// Scans a string to produce an array of glyphs.
enum InputParser  {

    static func createGlyphs(from string: String) -> CalcResult<[Glyph]> {
        var glyphs = [Glyph]()
        for scalarIndex in string.unicodeScalars.indices {
            if let glyph = parseGlyph(at: scalarIndex, in: string) {
                glyphs.append(glyph)
            }
            else {
                return .error(.unexpectedCharacter(at: scalarIndex.encodedOffset))
            }
        }
        return .value(glyphs)
    }

    private static func parseGlyph(at index: String.UnicodeScalarIndex, in string: String) -> Glyph? {
        enum CharacterSets {
            static let add              = CharacterSet(charactersIn: "+")
            static let decimalSeparator = CharacterSet(charactersIn: ".")
            static let digit            = CharacterSet.decimalDigits
            static let divide           = CharacterSet(charactersIn: "/")
            static let multiply         = CharacterSet(charactersIn: "*xX")
            static let parenthesisLeft  = CharacterSet(charactersIn: "(")
            static let parenthesisRight = CharacterSet(charactersIn: ")")
            static let subtractOrNegate = CharacterSet(charactersIn: "-")
            static let whitespace       = CharacterSet.whitespacesAndNewlines
        }
        let scalar = string.unicodeScalars[index]
        if CharacterSets.add.contains(scalar)              { return .add }
        if CharacterSets.decimalSeparator.contains(scalar) { return .decimalSeparator }
        if CharacterSets.digit.contains(scalar)            { return .digit(scalar) }
        if CharacterSets.divide.contains(scalar)           { return .divide }
        if CharacterSets.multiply.contains(scalar)         { return .multiply }
        if CharacterSets.parenthesisLeft.contains(scalar)  { return .parenthesisLeft }
        if CharacterSets.parenthesisRight.contains(scalar) { return .parenthesisRight }
        if CharacterSets.subtractOrNegate.contains(scalar) { return .subtractOrNegate }
        if CharacterSets.whitespace.contains(scalar)       { return .whitespace }
        return nil
    }

}
