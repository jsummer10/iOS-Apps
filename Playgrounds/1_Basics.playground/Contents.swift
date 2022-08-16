import UIKit

/*
 * Types
 */

// variable vs constant
var reg   = "Regular"
let const = "Constant"

// 32-bit Integer
var int1:Int    = 2
var int2:Int32  = 3
var int3:UInt32 = 4

// 64-bit Integer
var int4:Int64  = 5
var int5:UInt64 = 6

// 32-bit Float
var float1:Float = 1.25

// 64-bit Double
var double1:Double = 3.14

// Boolean
var bool1:Bool = true

// String
var string1:String = "Hello World"

// Character
var char1:Character = "A"

// Tuple
var tuple1 = (int1, int2, float1)

// Array
var array1 = [1, 2, 3]

/*
 * Conditions
 */

if int1 == 1 {
    print("Condition1 is A")
} else if int2 == 2 {
    print("Condition1 is B")
} else {
    print("Condition1 is C")
}

switch char1 {
case "A":
    print("Char1 is A")
case "B":
    print("Char1 is B")
default:
    print("Default")
}

// ternary operator
float1 = bool1 ? 5.5 : 20.1
// float1 = 5.5 if bool1 is true or 20.1 if false

/*
 * Loops
 */

for x in array1 {
    print(x)
}

var i = 0
while i < 3 {
    print(i)
    i += 1
}

var j = 0
repeat {
    print(j)
    j += 1
} while j < 3

