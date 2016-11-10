import Foundation

let textFieldOne: String? = "10"
let textFieldTwo: String? = "1"
var label = "SomeLabel"

if let numberOne = Int(textFieldOne), numberTwo = Int(textFieldTwo){
    label = (numberOne - numberTwo)
    print(label)
} else {
    label = "You really should have numbers y'know."
    print(label)
}