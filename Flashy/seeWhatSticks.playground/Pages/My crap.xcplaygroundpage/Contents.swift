import Foundation

class SomeClass {
    var value1: Int
    var value2: String
    init(value1 v1: Int, value2 v2: String) {
        self.value1 = v1
        self.value2 = v2
    }
}

var instance1 = SomeClass(value1: 6, value2: "Hello")
var instance2 = SomeClass(value1: 5, value2: "Hi!")
instance1.value1
var instance3 = instance2
instance3.value2
instance3.value2 = "Yo"
instance3.value2
instance2.value2
instance1.value2