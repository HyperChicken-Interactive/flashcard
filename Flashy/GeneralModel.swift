//
//  GeneralModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/22/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

/// The currently selected card, Right now it will be static but in ver 1.0 or beta it will be a dynamic function probably.
var currentlySelectedFlashyCardset: FlashySet = flashySuper

/// The currently selected color scheme, Right now it will be static but in ver 1.0 or beta it will be a dynamic function probably.
var currentlySelectedColorScheme: ColorScheme = SolarizedDark

/// A value that indicates wether edited cardsets should be commited to the currentlySelectedFlashyCardset automatically, or only when pressing the "done" button
var cardEditsWillAutoSave: Bool = unarchiveUserDefaults().1

/**
 ## Log important info for debugging.
 
 Log will... log a whole bunch of info with the date and time of it's happening (Within one-tenth of a second). If all fields are filled out, a rich error log will be made to make debugs easy.
 
 Put this anywhere and everywhere. Really.
 
 If all fields are filled out, a report will look like this:
 
      2016.11.13@13:50:51.9 : Updated values. File "ViewController.swift". Function: "UpdateValuesInView". Also:
        - Currently selected set is set01
        - A line of importance is line 12
        - Currently selected color scheme is carbon
 
 - parameter t: The most basic information. Something like "Updated values" or "changed color scheme"
 - parameter f: An optional to show what file the event happened in: "GeneralModel.swift"
 - parameter r: An optional to show what object or function this occured in.
 - parameter o: An optional that appends any needed information, like values that are important to the function it is run in.
 */
func loginfo(infoText t: String, fileOccured f: String?, objectRunIn r: String?, otherInfo o: [String]?){
    // I did this the quickest way I can. This should be refactored at all costs before beta or release.
    
    // Getting and formatting the date:
    let date = NSDate()
    let calendar = NSCalendar.current
    
    let year = calendar.component(.year, from: date as Date)
    let month = calendar.component(.month, from: date as Date)
    let day = calendar.component(.day, from: date as Date)
    let hour = calendar.component(.hour, from: date as Date)
    let minutes = calendar.component(.minute, from: date as Date)
    let seconds = calendar.component(.second, from: date as Date)
    
    let nanoInt = calendar.component(.nanosecond, from: date as Date)
    var nanoStr = String(nanoInt)
    for _ in 1...((nanoStr.characters.count)-5) {
        nanoStr = nanoStr.substring(to: nanoStr.index(before: nanoStr.endIndex))
    }
    let nanoseconds = nanoStr
    
    /// The item that will inevitably be printed.
    var toBePrinted: String = ("\(year)-\(month)-\(day)@\(hour):\(minutes):\(seconds).\(nanoseconds)")
    
    // Adding the info text
    if t.hasSuffix(".") || t.hasSuffix("!") || t.hasSuffix("?") {
        toBePrinted += ": \(t) "
    } else {
        toBePrinted += ": \(t). "
    }
        
    if let file = f {
        toBePrinted += "File: \"\(file)\". "
    }
    if let object = r {
        toBePrinted += "In object: \"\(object)\"."
    }
    
    toBePrinted += "\n"
    
    if let other = o {
        toBePrinted += "Also:\n"
        for time in other {
            toBePrinted += "  - \(time)\n"
        }
    }
    
    print(toBePrinted)
}

/// A synonym to loginfo()
func logdata(infoText t: String, fileOccured f: String?, objectRunIn r: String?, otherInfo o: [String]?){
    loginfo(infoText: t, fileOccured: f, objectRunIn: r, otherInfo: o)
}
