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

func forceEquivilency(setToBeWritten set1: FlashySet, setToBeRead set2: FlashySet) {
    set1.name = set2.name
    set1.shortName = set2.shortName
    set1.cardsetArray = set2.cardsetArray
    set1.cardsContained = set2.cardsContained
    print("Forced equivilency between \(set1) and \(set2) where \(set1) was written to.")
}