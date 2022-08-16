import UIKit

/*
 * Optional: This will need to be
 * unwrapped prior to use and produces xcode warnings.
 */

// Optional
var opt_var:Int? = 1

if opt_var != nil {
    let x = 1 + opt_var!
    print(x)
}

// optional binding: unwraps opt_var and does a nil check
if let opt_bind = opt_var {
    let y = 1 + opt_bind
    print(y)
}

struct Example {
    func something() {
        print("Something Cool")
    }
}

// optional chaining
var ex:Example? = nil
ex?.something() // does a nil check prior to calling something

// assign a value to ex and try again
ex = Example()
ex?.something()

/*
 * When to use:
 *  - don't want to set a default value
 *  - when you use nil to represent an unset state
 *  - when using a variable to reference data that may be nil
 */
