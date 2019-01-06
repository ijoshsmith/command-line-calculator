//
//  calc-result.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// The outcome of performing a step in the calculation pipeline.
enum CalcResult<Value: Equatable>: Equatable {

    case value(Value)
    case error(CalcError)

    func then<NextValue>(_ produceNextResult: (Value) -> CalcResult<NextValue>) -> CalcResult<NextValue> {
        switch self {
        case .value(let value): return produceNextResult(value)
        case .error(let error): return .error(error)
        }
    }
    
}
