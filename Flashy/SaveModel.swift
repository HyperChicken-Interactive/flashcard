//
//  SaveModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 9/6/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

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
    
    let result = NSKeyedArchiver.archiveRootObject(flashySetArray, toFile: "/Flashy/flashycards.plist")
    
    if result == true{
        loginfo(infoText: "Archived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There are \(flashySetArray.count) items."])
    } else {
        loginfo(infoText: "CRITICAL: Failed to archive data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There are \(flashySetArray.count) items."])
    }
}


func unarchiveFlashySets() -> ([FlashySet]) {
    if let flashyTemp = NSKeyedUnarchiver.unarchiveObject(withFile: "/Flashy/flashycards.plist") as? [FlashySet] {
        loginfo(infoText: "Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["File was found. Restoring from archive."])
        return flashyTemp
    } else {
        loginfo(infoText: "Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There was no archive availible. Creating empty array."])
        return []
    }
}

