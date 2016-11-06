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

/**
 # Saves flashy sets!
 
 This function takes the hard-coded value of flashySetArray, and saves it.
 
 This replaces the manual calls in the appdelegate.
 
 - parameter tbp: Sees if flashyCardArray needs to be primed to be saved. As of v4.0-alpha, build 10, this is a bug-fix instrument.
 */
func saveFlashySets(NeedsToBePrimed tbp: Bool){
    
    if tbp == true {
        flashySetArray = allFlashySetArrays
        flashySetArray.remove(at: 0)
        loginfo(infoText: "Primed flashySetArray for saving.", fileOccured: nil, objectRunIn: nil, otherInfo: nil)
    }
    
    NSKeyedArchiver.archiveRootObject(flashySetArray, toFile: "/flashyArchives")
    
    loginfo(infoText: "Archived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There are \(flashySetArray.count) items."])
}


func unarchiveFlashySets(_ c: inout [FlashySet]) {
    if let flashyTemp = NSKeyedUnarchiver.unarchiveObject(withFile: "flashyArchives") as? [FlashySet] {
        c = flashyTemp
        loginfo(infoText: "Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["File was found. Restoring from archive."])
    } else {
        c = []
        loginfo(infoText: "Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There was no archive availible. Creating empty array."])
    }
}

/*

let file = "flashyData.json"

func grabNameData(flashySets: Array<AnyObject>) -> (String, String) {
    var nameData: Array = [String]   
 
    for item in flashyNames {
       nameData.append(item.name!, item.shortName)
    }
 
    return 
}

func saveToJson(_ names: Array<String>, count index: Int) {
    //let name = names[index]
    if let jsonResult = responseObject as? Dictionary<String, AnyObject> {
        // do whatever with jsonResult
    }
    
}

*/
