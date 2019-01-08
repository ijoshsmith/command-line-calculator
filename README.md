# Command Line Calculator in Swift

![command line calculator](images/command-line.png)

## Overview

This repository contains a calculator program written in Swift 4.2 that can be used from the command line, along with this article which explains how the program works. There are suggested programming exercises at the bottom of this page, in case you are interested in adding new features to the calculator.

## Disclaimer 

This calculator was written as a programming exercise, and is not intended for general usage. Use of the calculator outside of its didactic capacity is strongly discouraged. The author claims no responsibility for problems caused by incorrect values produced by the calculator. Use at your own risk.

## Motivation
 
Sure, macOS comes with the built-in Calculator app and `bc` bash program. And there are plenty of free online calculators. The world doesn't need another way to crunch numbers on their Macs. But I didn't let that stop me from solving what I found to be a very interesting problem!

This calculator accepts input like `"1 + 2 * 3 + -(4 - 5)"`, crunches the numbers according to the standard [order of operations](https://en.wikipedia.org/wiki/Order_of_operations), and prints out `8`. Creating a simple solution for this problem was a fun, tricky challenge.

## Data Transformations

At the highest level, this program turns a string into either a number or an error message. Assuming the user provides valid input, the next level down can be viewed as turning a string into a tree of arithmetic expressions. A properly constructed expression tree can be recursively evaluated to produce the correct number to output. This concept can be visualized as so:

![expression tree](images/expression-tree.png)

Each of the following sub-sections describes a data transformation that moves from the user input to an output.

### Text -> Glyphs

todo

### Glyphs -> Tokens

todo

### Tokens -> Operations

todo

### Operations -> Expression

todo

### Expression -> Calculation

todo

## Programming Exercises

todo
