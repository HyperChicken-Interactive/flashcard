//
//  GUIColorModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/8/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

struct ColorScheme {
    let backgroundColor: UIColor
    // The most explanitory, the color for the background of the app.
    
    let flashcardColor: UIColor
    //Color of flashcards.
    
    let boxColor: UIColor
    // Color for label boxes or button boxes.
    
    let textColor: UIColor
    // Color for default label text.
    
    let highlightColor: UIColor
    // Highlight for buttons and not label items.
    
    let headerColor: UIColor
    // Highlight for labels like headers.
    
    
    init(backgroundColor bc: UIColor, flashcardColor fc: UIColor, boxColor bx: UIColor, textColor tc: UIColor, highlightColor hc: UIColor, headerColor hd: UIColor) {
        self.backgroundColor = bc
        self.flashcardColor = fc
        self.boxColor = bx
        self.textColor = tc
        self.highlightColor = hc
        self.headerColor = hd
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





