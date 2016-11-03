//
//  SaveModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 9/6/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

// WIP by @donovank
// *Now with documentation!!!* //

import Foundation



/*

let file = "flashyData.json"

/**
 Grabs *name* and *shortName* of a FlashySet, returns two variables.

 _let name, shortname = grabName(set01)_
*/

func grabName(cset: inout FlashySet) -> (String, String) {
    return (cset.name!, cset.shortName)
}

/**
 ## Save to JSON
 
 Saves the
*/
func saveToJson(_ names: Array<String>, count index: Int) {
    //let name = names[index]
    if let jsonResult = responseObject as? Dictionary<String, AnyObject> {
        // do whatever with jsonResult
    }
    
}
*/
