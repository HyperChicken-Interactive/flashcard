//
//  GUIColorModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/8/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

protocol FullyColored {
    var backgroundColor: UIColor { get }
        // The most explanitory, the color for the background of the app.
    var flashcardColor: UIColor { get }
        //Color of flashcards
    
    var boxColor: UIColor { get }
        // Color for label boxes or button boxes.
    
    var textColor: UIColor { get }
        // Color for default label text.
    
    var highlightColor: UIColor { get }
        // Highlight for buttons and not label items
    
    var headerColor: UIColor { get }
        // Highlight for labels like headers.
}

struct SolarizedDark: FullyColored {
    let backgroundColor: UIColor = UIColor(red: 0.0, green: 43.0, blue: 54.0, alpha: 1.0)
    let flashcardColor: UIColor = UIColor(red: 253.0, green: 246.0, blue: 227.0, alpha: 1.0)
    let boxColor: UIColor = UIColor(red: 7.0, green: 54.0, blue: 66.0, alpha: 1.0)
    let textColor: UIColor = UIColor(red: 147.0, green: 161.0, blue: 161.0, alpha: 1.0)
    let highlightColor: UIColor = UIColor(red: 220.0, green: 50.0, blue: 47.0, alpha: 1.0)
    let headerColor: UIColor = UIColor(red: 38.0, green: 139.0, blue: 210.0, alpha: 1.0)
}
