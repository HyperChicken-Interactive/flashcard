//
//  GeneralModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/22/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

var currentlySelectedFlashyCardset: FlashySet = flashySuper
// The currently selected card, Right now it will be static but in ver 1.0 or beta it will be a dynamic function probably.

var currentlySelectedColorScheme: ColorScheme = SolarizedDark

/// A unique identifier for FlashySets.
var idMarker: Int = 1

/**
 ## Log important info for debugging.
 
 Log will... log a whole bunch of info with the date and time of it's happening (Within one-tenth of a second). If all fields are filled out, a rich error log will be made to make debugs easy.
 
 Put this anywhere and everywhere. Really.
 
 If all fields are filled out, a report will look like this:
 
      2016.11.13@13:50:51.9 : Updated values for file "ViewController.swift", in function "UpdateValuesInView". Also:
        - Currently selected set is set01
        - A line of importance is line 12
        - Currently selected color scheme is carbon
 
 - parameter t: The most basic information. Something like "Updated values" or "changed color scheme"
 - parameter f: An optional to show what file the event happened in: "GeneralModel.swift"
 - parameter r: An optional to show what object or function this occured in.
 - parameter o: An optional that appends any needed information, like values that are important to the function it is run in.
 */
func log(infoText t: String, fileOccured f: String?, objectRunIn r: String?, otherInfo o: [String]?){
    // I did this the quickest way I can. This should be refactored at all costs before beta or release.
    
}



