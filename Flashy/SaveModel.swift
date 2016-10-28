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


let file = "flashyData.json"
let flashySets = [set01, set02, set03, set04, set05] // Yes Whitman, I understand it needs to be dynamic. I'll add that later.

/**
 Grabs *name* and *shortName* of a FlashySet, returns two variables.

 _let name, shortname = grabName(set01)_
*/

func grabName(cset: inout FlashySet) -> (String, String) {
    return (cset.name!, cset.shortName)
}

/**
 WIP, currently saves names to a json file.
*/

func saveToJson(_ names: Array<String>, count index: Int) {
    //let name = names[index]
    
    let flashCardData: [String: Int] = [
        "id": 1,
        //"name": name
    ]
    
}
