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
        let result = NSKeyedArchiver.archiveRootObject(tba, toFile: path)
        
        if result == true {
            logdata(infoText: "Successfully archived flashyset", fileOccured: nil, objectRunIn: "saveFlashySets(...)", otherInfo: ["There were \(tba.count) cards at archive time.", "Saved to file \(path)", "docs value of \(docs as NSString)", "Return value of call to NSKeyedArchiver.archiveRootObject was \(result)."])
        } else {
            logdata(infoText: "CRITICAL: Failed to archive flashyset", fileOccured: nil, objectRunIn: "saveFlashySets(...)", otherInfo: ["There were \(tba.count) cards at archive time.", "Saved to file \(path)", "docs value of \(docs as NSString)", "Return value of call to NSKeyedArchiver.archiveRootObject was \(result)."])
        }
    
    } else {
        logdata(infoText: "CRITICAL: Failed to archive data for flashyset", fileOccured: nil, objectRunIn: "saveFlashySets(...)", otherInfo: ["temp constant `docs` resolved to a nil value"])
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
            loginfo(infoText: "Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["File was found. Restoring from archive.", "Contains \(result.count) cards.", "Read from file \(path)"])
            fls = result
        } else {
            loginfo(infoText: "CRITICAL: Failed to unarchive data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There was no archive availible. Creating empty array.", "temp constant `result` returned a nil value.", "Read from file \(path)", "docs value of \(docs as NSString)"])
            fls = []
        }
    } else {
        loginfo(infoText: "CRITICAL: Failed Unarchive data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There was no archive availible. Creating empty array.", "temp constant `docs` returned a nil value."])
        fls = []
    }
}

func returnFlashySets() -> [FlashySet] {
    var tempArray: [FlashySet] = []
    unarchiveFlashySets(&tempArray)
    return tempArray
}

func archiveUserDefaults(CurentlySelectedColorScheme OPcscs: String?, AutoSaveFlashcards OPasf: Bool?) {
    let prefs = UserDefaults.standard
    
    if let cscs = OPcscs {
        prefs.set(cscs, forKey: "cscs")
        loginfo(infoText: "IMPORTANT: Archived currently selected colour scheme.", fileOccured: nil, objectRunIn: "archiveUserDefaults(...)", otherInfo: ["Value saved was \"\(cscs)\""])
    } else {
        loginfo(infoText: "IMPORTANT: Failed to archive currently selected colour scheme.", fileOccured: nil, objectRunIn: "archiveUserDefaults(...)", otherInfo: ["Found nil or equivilant.",
            "Exact passed value: \"\(OPcscs)\"."])
    }
    
    if let asf = OPasf {
        prefs.set(asf, forKey: "asf")
        loginfo(infoText: "IMPORTANT: Archived boolian of AutoSaveFlashcard.", fileOccured: nil, objectRunIn: "archiveUserDefaults(...)", otherInfo: ["Value saved was \"\(asf)\""])
    } else {
        loginfo(infoText: "IMPORTANT: Failed to archive preference AutoSaveFlashcards.", fileOccured: nil, objectRunIn: "archiveUserDefaults(...)", otherInfo: ["Found nil or equivilant.",
            "Exact passed value: \"\(OPasf)\"."])
    }
}

func unarchiveUserDefaults() -> (String, Bool) {
    let prefs = UserDefaults.standard
    var returnedTuple: (String, Bool)
    
    if let colorScheme = prefs.string(forKey: "cscs") {
        returnedTuple.0 = colorScheme
    } else {
        returnedTuple.0 = "Carbon"
        logdata(infoText: "CRITICAL: Found nil or equivilent while attempting to unwrap optional value.", fileOccured: nil, objectRunIn: "unarchiveUserDefaults()", otherInfo: ["Attempted to unwarp \"autoSaveCards\".",
            "Found value: \"\(prefs.object(forKey: "cscs"))\".",
            "In an attempt to prevent critical issues, the value has been set to \"Carbon\""])
    }
    
    
    if let autoSaveCards = prefs.object(forKey: "asf") as? Bool {
        returnedTuple.1 = autoSaveCards
    } else {
        returnedTuple.1 = true
        logdata(infoText: "CRITICAL: Found nil or equivilent while attempting to unwrap optional value.", fileOccured: nil, objectRunIn: "unarchiveUserDefaults()", otherInfo: ["Attempted to unwarp \"autoSaveCards\".",
                "Found value: \"\(prefs.object(forKey: "asf"))\".",
                "In an attempt to prevent critical issues, the value has been set to TRUE"])
    }
    
    return returnedTuple
}



