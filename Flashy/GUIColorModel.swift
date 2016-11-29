//
//  GUIColorModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/8/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

/**
 # Ooh! Pretty colours!
 
 This is a basic struct for color scheme. Should it be a protocol? yes. But that's beside the point. This structure containes values of `UIColour(r,g,b)` that can be passed to view objects like `UIButton`. These are all pre-defined and can be changed in the PreferenceViewController.
 */
struct ColorScheme {
    /// The most explanitory, the color for the background of the app.
    let backgroundColor: UIColor
    
    ///Color of flashcards.
    let flashcardColor: UIColor
    
    /// Color for label boxes or button boxes.
    let boxColor: UIColor
    
    /// Color for default label text.
    let textColor: UIColor
    
    /// Highlight for buttons and not label items.
    let highlightColor: UIColor
    
    /// Highlight for labels like headers.
    let headerColor: UIColor
    
    
    init(backgroundColor bc: UIColor, flashcardColor fc: UIColor, boxColor bx: UIColor?, textColor tc: UIColor, highlightColor hc: UIColor, headerColor hd: UIColor?) {
        self.backgroundColor = bc
        self.flashcardColor = fc
        self.textColor = tc
        self.highlightColor = hc
        
        if let box = bx {
            self.boxColor = box
        } else {
            self.boxColor = fc
        }
        if let header = hd {
            self.headerColor = header
        } else {
            self.headerColor = hc
        }
    }
}

let SolarizedDark: ColorScheme = ColorScheme(
    backgroundColor: UIColor(red: 0.0/255.0, green: 43.0/255.0, blue: 54.0/255.0, alpha: 1.0),
    flashcardColor: UIColor(red: 7.0/255.0, green: 54.0/255.0, blue: 66.0/255.0, alpha: 1.0),
    boxColor: UIColor(red: 7.0/255.0, green: 54.0/255.0, blue: 66.0/255.0, alpha: 1.0),
    textColor: UIColor(red: 147.0/255.0, green: 161.0/255.0, blue: 161.0/255.0, alpha: 1.0),
    highlightColor: UIColor(red: 220.0/255.0, green: 50.0/255.0, blue: 47.0/255.0, alpha: 1.0),
    headerColor: UIColor(red: 38.0/255.0, green: 139.0/255.0, blue: 210.0/255.0, alpha: 1.0))

let solarizedLight: ColorScheme = ColorScheme(
    backgroundColor: UIColor(red: 253.0/255.0, green: 246.0/255.0, blue: 227.0/255.0, alpha: 1.0),
    flashcardColor: UIColor(red: 238.0/255.0, green: 232.0/255.0, blue: 213.0/255.0, alpha: 1.0),
    boxColor: UIColor(red: 238.0/255.0, green: 232.0/255.0, blue: 213.0/255.0, alpha: 1.0),
    textColor: UIColor(red: 101.0/255.0, green: 123.0/255.0, blue: 131.0/255.0, alpha: 1.0),
    highlightColor: UIColor(red: 220.0/255.0, green: 50.0/255.0, blue: 47.0/255.0, alpha: 1.0),
    headerColor: UIColor(red: 38.0/255.0, green: 139.0/255.0, blue: 210.0/255.0, alpha: 1.0))

let carbonColors: ColorScheme = ColorScheme(
    backgroundColor: UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0),
    flashcardColor: UIColor(red: 28.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0),
    boxColor: UIColor(red: 28.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0),
    textColor: UIColor(red: 194.0/255.0, green: 194.0/255.0, blue: 194.0/255.0, alpha: 1.0),
    highlightColor: UIColor(red: 42.0/255.0, green: 161.0/255.0, blue: 152.0/255.0, alpha: 1.0),
    headerColor: UIColor(red: 212.0/255.0, green: 157.0/255.0, blue: 221.0/255.0, alpha: 1.0))

// 242, 242, 245.

let showroomColors: ColorScheme = ColorScheme(
    backgroundColor: UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 245.0/255.0, alpha: 1.0),
    flashcardColor:  UIColor(red: 128.0/255.0, green: 135.0/255.0, blue: 133.0/255.0, alpha: 0.5),
    boxColor:  UIColor(red: 128.0/255.0, green: 135.0/255.0, blue: 133.0/255.0, alpha: 0.25),
    textColor: UIColor(red: 166.0/255.0, green: 23.0/255.0, blue: 2.0/255.0, alpha: 1.0),
    highlightColor: UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0),
    headerColor: nil)


/**
 # Switches and saves colour scheme
 
 This function handles changing from one colour scheme to another, and how the `currentlySelectedColorScheme` is saved.
 - parameter OPscheme: an optional parameter that defines what the new colour scheme is. It will be written to NSUserDefaults (Now UserDefaults in Swift 3.0.*). If nil, the function wil try to get one from UserDefaults. Failing that, will default to CarbonColors.
 */
func swapColorScheme(to OPscheme: String?){
    
    // Call and get instance of standard user defaults.
    
    if let scheme = OPscheme {
        
        // Set & saves the new colour scheme.
        archiveUserDefaults(CurentlySelectedColorScheme: scheme, AutoSaveFlashcards: nil)
        
        switch scheme{
            case "Solarized Dark": currentlySelectedColorScheme = SolarizedDark
            case "Solarized Light": currentlySelectedColorScheme = solarizedLight
            case "Carbon": currentlySelectedColorScheme = carbonColors
            case "Showroom": currentlySelectedColorScheme = showroomColors
            default: logdata(infoText: "Failed to change color scheme", fileOccured: nil, objectRunIn: nil, otherInfo: ["Attempted to select color scheme \(scheme)"])
        }
        
    } else {
        let scheme = unarchiveUserDefaults().0
        
        switch scheme{
        case "Solarized Dark": currentlySelectedColorScheme = SolarizedDark
        case "Solarized Light": currentlySelectedColorScheme = solarizedLight
        case "Carbon": currentlySelectedColorScheme = carbonColors
        case "Showroom": currentlySelectedColorScheme = showroomColors
        default: logdata(infoText: "Failed to change color scheme", fileOccured: nil, objectRunIn: "else clause from swapcolorscheme()", otherInfo: ["Attempted to select color scheme \(scheme)"])
        }
    }
}





