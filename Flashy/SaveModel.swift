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
 
 - parameter tba: The flashyset array to be archived.
 */

func saveFlashySets(_ tba: [FlashySet]){
    if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
        
        // Append your file name to the directory path
        let path = (docs as NSString).appendingPathComponent("flashysets.plist")
        
        // Archive your object to a file at that path
        NSKeyedArchiver.archiveRootObject(tba, toFile: path)
    
    } else {
        logdata(infoText: "CRITICAL: Failed to archive data for Set", fileOccured: nil, objectRunIn: "saveFlashySets(...)", otherInfo: nil)
    }
}

/**
 # Unarchive Cardsets from flashycards.plist
 
 This function unarchives a flashyset from the file flashysets.plist.
 
 - parameter fls: The flashyset to be written to from archive. This should probably be flashySetArray
 */
func unarchiveFlashySets(_ fls: inout [FlashySet]) {
    
    if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
        
        // Append your file name to the directory path
        let path = (docs as NSString).appendingPathComponent("flashysets.plist")
        
        // Unarchive your object from the file
        if let result = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [FlashySet] {
            loginfo(infoText: "Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["File was found. Restoring from archive."])
            fls = result
        } else {
            print ("Bloody hell! We're going to need more power to turn this around!")
            loginfo(infoText: "CRITICAL: Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There was no archive availible. Creating empty array."])
            fls = []
        }
    }
}














