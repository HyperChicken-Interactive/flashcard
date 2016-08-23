// A place where I can try out random theories.

import Foundation

/*
class SomeSuper {
    var someString: String
    init(someString ss: String){
        self.someString = ss
    }
}

class SomeChild: SomeSuper{}
class SomeEdit: SomeSuper{}

var someChild: SomeSuper = SomeChild(someString: "String A")

var pointer: SomeSuper = someChild

var someEdit = SomeEdit(someString: "String B")

//someEdit = pointer

someEdit.someString

let myString = "Hello"

let someArray = [1, 2, 3, 4, 6]
*/

import UIKit

class ViewController: UIViewController {
    
    @IBAction func showAlertButtonTapped(sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "UIAlertController", message: "Would you like to continue learning how to use iOS alerts?", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
