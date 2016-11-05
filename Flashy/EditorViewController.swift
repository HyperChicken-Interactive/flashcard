//
//  EditorViewController.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/23/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UITextFieldDelegate{
    // The view controller for the flashy editor and customizer.
    
    ////////////////////////////////////////
    // And now, some wonderful IBOutlets: //
    ////////////////////////////////////////]
    
    /// A UITextField for modifying the name of the cardset being modified.
    @IBOutlet weak var cardsetNameOutlet: UITextField!
    
    /// A UITextField for modifying the short name of the cards.
    @IBOutlet weak var cardsetShortOutlet: UITextField!

    /// A UITextField for generating side one of the cards.
    @IBOutlet weak var sideOneOutlet: UITextField!
    
    /// A UITextField for generating side two of the cards.
    @IBOutlet weak var sideTwoOutlet: UITextField!
    
    /// an outlet for the label that displays the card number. Controlls color scheme and text.
    @IBOutlet weak var cardNumberOutlet: UILabel!
    
    /// an outlet for the "DONE" button to control the color scheme and if it is hidden or not.
    @IBOutlet weak var doneOutlet: UIButton!
    
    /// an outlet for the "PREVIOUS" button to control the color scheme and if it is hidden or not.
    @IBOutlet weak var previousOutlet: UIButton!
    
    /// an outlet for the "NEXT" button to control the color scheme and if it is hidden or not.
    @IBOutlet weak var nextOutlet: UIButton!
    
    
    ///////////////////////////////////////////////////////
    // Fresh home-made functions and variables! By hand! //
    ///////////////////////////////////////////////////////
    
    
    /// Updates a whole ton of values to fit the color scheme selected and data passed by outlets like `cardsetName` and `sideOne`.
    func updateValuesInView(){
        
        //////////////////////////////////
        // Updating text and visability //
        //////////////////////////////////
        
        editSet.shortName = cardsetShortOutlet.text!
        editSet.name = cardsetNameOutlet.text!
        
        cardsetNameOutlet.text = editSet.name
        cardsetShortOutlet.text = editSet.shortName
        
        // The following if statment handles the next and previous buttons as according to the currently selected card
        if editSet.cardsInSet == 0 /* Handle if unmade cardset */{
            
            previousOutlet.isHidden = true
            nextOutlet.isHidden = true
        } else if editSet.cardsInSet == editSet.currentlySelectedFlashyCard /*If the currently selected card is out of range of the count*/ {
            previousOutlet.isHidden = false
            nextOutlet.isHidden = true
        } else if editSet.currentlySelectedFlashyCard == 0 /*If the selected card is #0. If it's a new set, this will be ignored because the first option has been fufilled.*/ {
            previousOutlet.isHidden = true
            nextOutlet.isHidden = false
        } else /*If no other clause has been met, show the outlets*/ {
            previousOutlet.isHidden = false
            nextOutlet.isHidden = false
        }
        
        // The following if statment handles if the card's edits should be saved and if the next, previous, and done buttons should be visable as according to the text the fields contain.
        if sideOneOutlet.text!.isEmpty == false && sideTwoOutlet.text!.isEmpty == false && editSet.currentlySelectedFlashyCard < editSet.cardsInSet {
            
            editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideOne = sideOneOutlet.text!
            editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideTwo = sideTwoOutlet.text!
            
            print("Modified card #\(editSet.currentlySelectedFlashyCard)")
            
        } else if sideOneOutlet.text!.isEmpty == false && sideTwoOutlet.text!.isEmpty == false && editSet.currentlySelectedFlashyCard == editSet.cardsInSet {
            editSet.generateNewCard(sideOneOfCard: sideOneOutlet.text!, sideTwoOfCard: sideTwoOutlet.text!)
            
            print("Created new card for \"\(editSet.name)\".")
        }
        
        if editSet.shortName.isEmpty == true {
            doneOutlet.isHidden = true
        } else {
            doneOutlet.isHidden = false
        }
        
        //
        
        // The following if statment handles pre-made card text to be put in the UITextFields.
        if editSet.cardsInSet > 0 && editSet.currentlySelectedFlashyCard < editSet.cardsInSet /*Makes sure that the card selected is not new and has already been made before but is just here for editing*/ {
            sideOneOutlet.text = editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideOne
            sideTwoOutlet.text = editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideTwo
        }
        
        cardNumberOutlet.text = "Card #\(editSet.currentlySelectedFlashyCard+1)"
        //Shows what card you are on.
        
        ///////////////////////////
        // Updating color scheme //
        ///////////////////////////
        
        cardsetNameOutlet.attributedPlaceholder = NSAttributedString(string: "Cardset Name",attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.headerColor])
        //
        cardsetNameOutlet.textColor = currentlySelectedColorScheme.headerColor
        cardsetNameOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        // delt with the cardset name
        
        cardsetShortOutlet.attributedPlaceholder = NSAttributedString(string: "Enter shortname", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.highlightColor])
        cardsetShortOutlet.textColor = currentlySelectedColorScheme.highlightColor
        cardsetShortOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        // Sets the shortname to whatever the currently selected set's sn is (non optional)
            
        sideOneOutlet.attributedPlaceholder = NSAttributedString(string: "Side 1", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.textColor])
        // Updating side one to say "Enter side one"
            
        sideTwoOutlet.attributedPlaceholder = NSAttributedString(string: "Side 2", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.textColor])
        // see above
        
        // Set all placeholders.
        
        
        sideOneOutlet.textColor = currentlySelectedColorScheme.textColor
        sideOneOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        sideTwoOutlet.textColor = currentlySelectedColorScheme.textColor
        sideTwoOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        cardNumberOutlet.textColor = currentlySelectedColorScheme.textColor
        cardNumberOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        doneOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        doneOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        previousOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        previousOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        nextOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        nextOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        view.backgroundColor = currentlySelectedColorScheme.backgroundColor
        
        loginfo(infoText: "Updated view values", fileOccured: "EditorViewController.swift", objectRunIn: title, otherInfo: ["Remember this could be a cause of Issue Git:2", "There are currently \(editSet.cardsInSet) cards."])
    }
    
    //////////////////////////
    // The viewDidLoad func //
    //////////////////////////
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        
        editSet.forceEquivilency(setToBeRead: currentlySelectedFlashyCardset, fileRunFrom: "EditorViewController.swift")
        cardsetNameOutlet.delegate = self
        cardsetShortOutlet.delegate = self
        sideOneOutlet.delegate = self
        sideTwoOutlet.delegate = self
        
        // Set the shortname.
        cardsetShortOutlet.text = editSet.shortName
        
        // Set the Long-name
        cardsetNameOutlet.text = editSet.name
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        updateValuesInView()
        
        loginfo(infoText: "View loaded successfully", fileOccured: "EditorViewController.swift", objectRunIn: title, otherInfo: nil)
    }
    
    ////////////////////////////////////////////////////////////////
    // Get your brand new IBAction functions here! (and the like) //
    ////////////////////////////////////////////////////////////////
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        self.view.endEditing(true)
        updateValuesInView()
        updateValuesInView()
        return false
    }
    
    /// Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        updateValuesInView()
        updateValuesInView()
    }
    
    /**
    The function that is run when the "DONE" button is pressed:
     
     - Pops up an alert that makes sure you want to save and quit.
     - Alert has two buttons
     - *Cancel* does nothing
     - *Save* forces eqivilency `forceEquivilency()` between the `currentlySelectedFlashyCardset` and `editSet` where `currentlySelectedFlashyCardset` will be written to. It then segues back to the main menu.
     
    */
    @IBAction func doneAction() {
        let alert = UIAlertController(title: "Hold on!", message: "Would you like to save and quit the flashcard set? This will override what is currently in \(currentlySelectedFlashyCardset.name!)", preferredStyle: UIAlertControllerStyle.alert)
            // Makes the body for an alert.
        
        // add the actions (buttons)
        // The "go" button
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { action in
            
            currentlySelectedFlashyCardset.forceEquivilency(setToBeRead: editSet, fileRunFrom: "editorViewController.swift")
            self.performSegue(withIdentifier: "editorToMainSegue", sender: nil)
        }))
        
        // The cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
       
    }
    
    @IBAction func previousAction() {
        editSet.currentlySelectedFlashyCard -= 1
        
        sideOneOutlet.text = ""
        sideTwoOutlet.text = ""
        
        print("Previous button pressed")
        updateValuesInView()
    }
    
    @IBAction func nextAction() {
        editSet.currentlySelectedFlashyCard += 1
        
        sideOneOutlet.text = ""
        sideTwoOutlet.text = ""
        
        print("Next button pressed")
        updateValuesInView()
    }
    
    
    
    
}

