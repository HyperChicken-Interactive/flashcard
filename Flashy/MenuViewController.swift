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
    
    /// An outlet that says "Welcome to flashy"
    @IBOutlet weak var welcomeOutlet: UILabel!
    
    /// The outlet that displays the name of the currently selected set.
    @IBOutlet weak var cardsetNameOutlet: UILabel!
    
    /// The outlet that displays the number of cards in the selected set.
    @IBOutlet weak var numberOfCardsOutlet: UILabel!
    
    /** The outlet for the "flash" button.
     This is not what is used for moving from the `menu` to the `flash` view. That is hard coded on the main.storyboard somewhere. This outlet is used for changing text, font, hidden values as needed.
     */
    @IBOutlet weak var flashOutlet: UIButton!
    
    /** The outlet for the "edit" (or "new") button.
     This is not what is used for moving from the `menu` to the `edit` view. See editAction() function for that. This outlet is used for changing text, font, hidden values as needed.
     */
    @IBOutlet weak var editOutlet: UIButton!
    
    /** The outlet for the "settings" button.
     This is not what is used for moving from the `menu` to the `preferences` view. That is hard coded on the main.storyboard somewhere. This outlet is used for changing text, font, hidden values as needed.
     */
    @IBOutlet weak var settingsOutlet: UIButton!
    
    /** The outlet for the selector.
     I don't even know. It has functions I guess.
     Don't ask.
     */
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
        cardsetNameOutlet.text = currentlySelectedFlashyCardset.name
        
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
    
    var flashcardList: [String] {
        return iterateCardsetShortnames()
    }
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
    
    func appendNewCardsetIfNeeded() {
        
        // Checks to see if the currently selected card is the card used in creating new cardset arrays. If it is, then append an emtpty cardset to the list.
        if currentlySelectedFlashyCardset == flashySuper {
            flashySetArray.append(FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: "", isIgnored: false, cardsInSet: nil))
            currentlySelectedFlashyCardset = flashySetArray[((flashySetArray.count)-1)]
            loginfo(infoText: "IMPORTANT: Changed currently selected cardset.", fileOccured: "EditorViewController.swift", objectRunIn: "viewDidLoad()", otherInfo: ["Appended one cardset to the flashySetArray.", "Meaning there are \(flashySetArray.count) cardsets."])
        }
    }
    
    //////////////////////////
    // The viewDidLoad func //
    //////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cardsetPickerOutlet.dataSource = self
        cardsetPickerOutlet.delegate = self
        currentlySelectedFlashyCardset = flashySuper
        updateValuesInView()
        
        loginfo(infoText: "View loaded successfully", fileOccured: "MenuViewController.swift", objectRunIn: title, otherInfo: nil)
    }
    
    /////////////////////////////////////////////////
    // Get your brand new IBAction functions here! //
    /////////////////////////////////////////////////
    
    @IBAction func editAction() {
        logdata(infoText: "[ Edit | New ] button pressed.", fileOccured: "MenuViewController.swift", objectRunIn: "MenuViewController -> appendNewCardset", otherInfo: nil)
        appendNewCardsetIfNeeded()
        self.performSegue(withIdentifier: "mainToEditorSegue", sender: nil)
        logdata(infoText: "Successfully segued from Main >>> Editor.", fileOccured: "MenuViewController.swift", objectRunIn: "MenuViewController -> appendNewCardset", otherInfo: nil)
    }
    
    
    
}
