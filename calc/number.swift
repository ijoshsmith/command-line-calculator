//
//  number.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// A numeric value with a whole or fractional value.
enum Number: Equatable, CustomDebugStringConvertible {

    case int(Int)
    case double(Double)

    var debugDescription: String {
        switch self {
        case .int(let intValue):
            return String(intValue)
        case .double(let doubleValue):
            // Avoid printing decimal places for a whole number.
            if doubleValue.rounded() == doubleValue {
                let intValue = Int(doubleValue)
                return Number.int(intValue).debugDescription
            }
            else {
                return String(doubleValue)
            }
        }
    }
    
}
