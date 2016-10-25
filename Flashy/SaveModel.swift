//
//  SaveModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 9/6/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import Foundation
import CoreData

/**
 ## Unarcives general settings and cardset unique IDs

 The function that **MUST** be run when the app is opened.
 This function unarchives the currently selected color scheme and the highest version of the unique identifier
 */
func firstUnarchive() {
    let generalFile = "generalSaved.txt"
    let cardsetFile = "uniqueID.txt"
}

/** 
A function that takes one cardset, and saves it to a file called "flashyset@${UniqueID}.txt". For instance, if the cardset's id was 512, the file would be called flashyset@512.txt. 
 
Due to the fact that we have no idea what we're doing, it will delete the previous file called "flashyset@512.txt" and make a new one with updated data.
 
All cardsets will run this when the app is being put in the background or when it is closing.
 
- parameter fcs: The cardset that is acted apon.
 */
func archiveCards(FlashyCardset fcs: FlashySet) {
    let file = "flashyset@\(fcs.uniqueID).txt"
    
}

/** A function that takes one cardset, and assigns it values as according to the file that shares it's unique identifier.
 
 All cardsets will attempt to run this on app startup.
 
 FirstUnarchive() will fetch the unique identifiers and should ALWAYS WITH NO EXEPTIONS BE RUN **BEFORE** this function is run which is why it won't fail miserably when run.
 
 - parameter fcs: The cardset that is acted apon.
*/
func unarchiveCards(FlashyCardset fcs: FlashySet){
    let file = "flashyset@\(fcs.uniqueID).txt"
}
