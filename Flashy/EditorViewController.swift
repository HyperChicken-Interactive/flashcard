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
        
        editSet.name = cardsetNameOutlet.text!
        cardsetNameOutlet.text = editSet.name
        
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
        
        if sideOneOutlet.text!.isEmpty == false /*If side 1 is not empty*/ && sideTwoOutlet.text!.isEmpty == false /*If side 2 is not empty*/ && editSet.currentlySelectedFlashyCard < editSet.cardsInSet /*If the currently selected card is less than the number of cards in set. Remember that cardsInSet counts from 1.*/ {
            
            editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideOne = sideOneOutlet.text!
            editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideTwo = sideTwoOutlet.text!
            
            logdata(infoText: "Modified card #\(editSet.currentlySelectedFlashyCard)", fileOccured: "EditorViewController.swift", objectRunIn: "updateValuesInView()", otherInfo: ["Side one is now: \(editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideOne)", "Side two is now: \(editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideTwo)"])
            
        } else if sideOneOutlet.text!.isEmpty == false && sideTwoOutlet.text!.isEmpty == false && editSet.currentlySelectedFlashyCard == editSet.cardsInSet {
            editSet.generateNewCard(sideOneOfCard: sideOneOutlet.text!, sideTwoOfCard: sideTwoOutlet.text!)
            
            logdata(infoText: "Created new card for \"\(editSet.name)\".", fileOccured: "EditorViewController.swift", objectRunIn: "UpdateValuesInView", otherInfo: nil)
        }
        
        if editSet.name.isEmpty == true {
            doneOutlet.isHidden = true
            logdata(infoText: "Hid the done button", fileOccured: "EditorViewController.swift", objectRunIn: "updateValuesInView()", otherInfo: ["The done button was hidden because there is no name."])
        } else {
            doneOutlet.isHidden = false
            logdata(infoText: "Showing the done button", fileOccured: "EditorViewController.swift", objectRunIn: "updateValuesInView()", otherInfo: ["The done button is shown because there is a name.", "The value of the name is \(editSet.name)"])
        }
        
        // The following if statment handles pre-made card text to be put in the UITextFields.
        if editSet.currentlySelectedFlashyCard < editSet.cardsInSet /*Makes sure that the card selected is not new and has already been made before but is just here for editing*/ {
            sideOneOutlet.text = editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideOne
            sideTwoOutlet.text = editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideTwo
        }
        
        cardNumberOutlet.text = "Card #\(editSet.currentlySelectedFlashyCard+1)"
        //Shows what card you are on.
        
        ///////////////////////////
        // Updating color scheme //
        ///////////////////////////
        
        cardsetNameOutlet.attributedPlaceholder = NSAttributedString(string: "[Name]", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.headerColor])
        //
        cardsetNameOutlet.textColor = currentlySelectedColorScheme.headerColor
        cardsetNameOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        // delt with the cardset name
        
        sideOneOutlet.attributedPlaceholder = NSAttributedString(string: "[Side 1]", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.textColor])
        // Updating side one to say "Enter side one"
            
        sideTwoOutlet.attributedPlaceholder = NSAttributedString(string: "[Side 2]", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.textColor])
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
        sideOneOutlet.delegate = self
        sideTwoOutlet.delegate = self
        
        // Set the name
        cardsetNameOutlet.text = editSet.name
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        updateValuesInView()
        
        editSet.currentlySelectedFlashyCard = 0
        
        loginfo(infoText: "View loaded successfully", fileOccured: "EditorViewController.swift", objectRunIn: title, otherInfo: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        loginfo(infoText: "A memory warning was recived", fileOccured: "FlashViewController.swift", objectRunIn: nil, otherInfo: nil)
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
        
        let alert = UIAlertController(title: "Hold on!", message: "Would you like to save and quit the flashcard set? This will override what is currently in this set.", preferredStyle: UIAlertControllerStyle.alert)
        // Makes the body for an alert.
            
        // add the actions (buttons)
        // The "go" button
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { action in
            
            editSet.currentlySelectedFlashyCard = 0
            currentlySelectedFlashyCardset.forceEquivilency(setToBeRead: editSet, fileRunFrom: "editorViewController.swift")
            self.performSegue(withIdentifier: "editorToMainSegue", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { action in
            editSet.currentlySelectedFlashyCard = 0
            
            // Now we create a "Are you sure?" alert so people don't acidentally press the big red button
            
            let alert = UIAlertController(title: "Whoah there buck-o!", message: "Are you sure you want to delete this? Once deleted, the set cannot be recovered.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Destroy set", style: UIAlertActionStyle.destructive, handler: { action in
                
                editSet.currentlySelectedFlashyCard = 0
                if let indexID = flashySetArray.index(of: currentlySelectedFlashyCardset){
                    flashySetArray.remove(at: indexID)
                } else {
                    logdata(infoText: "CRITICAL: Index out of range.", fileOccured: "EditorViewController.swift", objectRunIn: "doneAction()",
                        otherInfo: ["When trying to find cardset \"\(currentlySelectedFlashyCardset.name)\" in range of flashySetArray, a value of \"nil\" (or simmilar) was found. Which does not comply with flashySetArray.",
                            "Due to this error being encapsulated within an if-let optional unwrapper, it is impossible to check the actual result that was returned.",
                            "The error was caught successfully, but due to this being a major logical issue. Even so, the app might be more volitile. This will be reported to the user."])
                    
                    let alert = UIAlertController(title: "CRITICAL.", message: "The set that is currently attempting to be removed was not found do to god-knows-what. Please contact the head of development (whitman.colm@gmail.com) as soon as possible. Thank you.", preferredStyle: UIAlertControllerStyle.alert)
                     alert.addAction(UIAlertAction(title: "Understood.", style: UIAlertActionStyle.destructive, handler: { action in
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                self.performSegue(withIdentifier: "editorToMainSegue", sender: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
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
    
        updateValuesInView()
        logdata(infoText: "Next Button Pressed", fileOccured: "EditorViewController.swift", objectRunIn: "previousAction()", otherInfo: ["Moving from \(editSet.currentlySelectedFlashyCard+1) to \(editSet.currentlySelectedFlashyCard)."])
    }
    
    @IBAction func nextAction() {
        editSet.currentlySelectedFlashyCard += 1
        
        sideOneOutlet.text = ""
        sideTwoOutlet.text = ""
        
        logdata(infoText: "Next Button Pressed", fileOccured: "EditorViewController.swift", objectRunIn: "nextAction()", otherInfo: ["Moving from \(editSet.currentlySelectedFlashyCard-1) to \(editSet.currentlySelectedFlashyCard)."])
        updateValuesInView()
    }
}

