// A place where I can try out random theories.

import Foundation

struct SomeStruct{
    var someString: String
}

var someInstance = SomeStruct(someString: "Hello")
var myPointer = someInstance

myPointer.someString = "Yo."

print(myPointer.someString)



