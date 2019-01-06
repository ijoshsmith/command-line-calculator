//
//  expression.swift
//  calc
//
//  Created by Josh Smith.
//  Copyright © 2019 iJoshSmith. All rights reserved.
//

/* A node in a tree used for calculating a numeric value.

 (1 + 2) * 3 - 4

       -
      / \
     *   4
    / \
   +   3
  / \
 1   2

 */
indirect enum Expression: Equatable {

    // Initial value
    case empty

    // Leaf node
    case number(Number)

    // Branch nodes
    case add(Expression, Expression)
    case divide(Expression, Expression)
    case multiply(Expression, Expression)
    case subtract(Expression, Expression)
    
}
