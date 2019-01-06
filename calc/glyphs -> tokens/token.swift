//
//  token.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/// An interpretation of a chunk of text.
enum Token: Equatable {

    case add
    case divide
    case multiply
    case number(Number)
    case parenthesisLeft(negated: Bool)
    case parenthesisRight
    case subtract
    
}
