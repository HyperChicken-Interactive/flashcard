//
//  MenuViewController.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/22/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    // This is the ViewController for the menu view, which is the view you see upon start up
    ////////////////////////////////////////
    // And now, some wonderful IBOutlets: //
    ////////////////////////////////////////
    
    @IBOutlet weak var welcomeOutlet: UILabel!
    @IBOutlet weak var cardsetNameOutlet: UILabel!
    @IBOutlet weak var numberOfCardsOutlet: UILabel!
    @IBOutlet weak var flashOutlet: UIButton!
    @IBOutlet weak var editOutlet: UIButton!
    @IBOutlet weak var settingsOutlet: UIButton!
    @IBOutlet weak var cardsetPickerOutlet: UIPickerView!
    
    ///////////////////////////////////////////////////////
    // Fresh home-made functions and variables! By hand! //
    ///////////////////////////////////////////////////////
    
    /** 
 #  Updates view with most recent values
     
 Run often. This will update all values in view with the most recent data in the viewcontroller.
     
 KNOWN BUGS:
     - Possible cause for git issue #2 [Tags: bug, enhancment]
 
 */
    func updateValuesInView() {
        
        saveFlashySets(flashySetArray)
        logdata(infoText: "saved flashcard set for good measure", fileOccured: nil, objectRunIn: nil, otherInfo: ["There are currently \(flashySetArray.count) cards.", "At index value, that means there are \(flashySetArray.count-1) cards."])
        unarchiveFlashySets(&flashySetArray)
        logdata(infoText: "unarchived flashcard set", fileOccured: nil, objectRunIn: nil, otherInfo: ["There are currently \(flashySetArray.count) cards.", "At index value, that means there are \(flashySetArray.count-1) cards."])
        
        // Any changes that need to be made to the text
        if let cardsetName = currentlySelectedFlashyCardset.name {
            cardsetNameOutlet.text = cardsetName
        } else {
            cardsetNameOutlet.text = "Select a cardset from the picker"
        }
        // Sets the cardset title to the name of the selected set, if that fails, it tells you to select a cardset.
        
        numberOfCardsOutlet.text = "\(currentlySelectedFlashyCardset.cardsInSet) cards"
        
        if currentlySelectedFlashyCardset.isIgnored == true {
            flashOutlet.isHidden = true
            editOutlet.isHidden = false
            editOutlet.setTitle("New", for: UIControlState.normal)
        } else {
            flashOutlet.isHidden = false
            editOutlet.isHidden = false
            editOutlet.setTitle("Edit", for: UIControlState.normal)
        }
        
        if currentlySelectedFlashyCardset.cardsetArray.count == 0 {
            flashOutlet.isHidden = true
        } else {
            flashOutlet.isHidden = false
        }
        
        // Coloring the everything
        welcomeOutlet.textColor = currentlySelectedColorScheme.headerColor
        welcomeOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        cardsetNameOutlet.textColor = currentlySelectedColorScheme.highlightColor
        cardsetNameOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        numberOfCardsOutlet.textColor = currentlySelectedColorScheme.textColor
        numberOfCardsOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        flashOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        flashOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        editOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        editOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        settingsOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        settingsOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        view.backgroundColor = currentlySelectedColorScheme.backgroundColor
        cardsetPickerOutlet.tintColor = currentlySelectedColorScheme.textColor
        
        loginfo(infoText: "Updated values in view", fileOccured: "MenuViewController.swift", objectRunIn: title, otherInfo: ["There are currently \(flashcardList.count) cards. (flashcardList.count)",
            "Meaning, there are currently \(flashySetArray.count) cards. (flashySetArray.count)"])

        
    }
    
    // Now we deal with the picker
    
    let flashcardList = iterateCardsetShortnames()
    // The data for the picker.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    } // The number of components in the picker, EG 3 for dates (Day, month, year)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return flashcardList.count
    } // The number of rows, which is the .count of our data, colorSelectData.
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return flashcardList[row]
    } // Gives names to the rows
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = flashcardList[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 15.0)!,NSForegroundColorAttributeName:currentlySelectedColorScheme.highlightColor])
        return myTitle
    } // Colors the text. Avenir won't work but fine.
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0 {
            loginfo(infoText: "Attemtpting to select superset flashcard.", fileOccured: "MenuViewController.swift", objectRunIn: "pickerView (Line 112)", otherInfo: nil)
            currentlySelectedFlashyCardset = flashySuper
        } else {
            loginfo(infoText: "Attemtpting to select flashcard \(row-1).", fileOccured: "MenuViewController.swift", objectRunIn: "pickerView (Line 112)", otherInfo: ["The current count of flashySetArray is: \(flashySetArray.count)", "At index value, that means there are \(flashySetArray.count-1) cards."])
            currentlySelectedFlashyCardset = flashySetArray[(row-1)]
        }
        updateValuesInView()
    } // Preforms an action when an items is selected.
    
    //////////////////////////
    // The viewDidLoad func //
    //////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This is here purely because this will be the most visited view. I need to think of a more-clever way to do this (mass refactor)
        
        /*
        for time in allFlashySetArrays{
            if time.isIgnored == false {
                
            }
        }
        */
        
        cardsetPickerOutlet.dataSource = self
        cardsetPickerOutlet.delegate = self
        currentlySelectedFlashyCardset = flashySuper
        updateValuesInView()
        
        loginfo(infoText: "View loaded successfully", fileOccured: "MenuViewController.swift", objectRunIn: title, otherInfo: nil)
    }
    
    /////////////////////////////////////////////////
    // Get your brand new IBAction functions here! //
    /////////////////////////////////////////////////
}
