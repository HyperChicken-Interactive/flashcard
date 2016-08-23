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
    ////////////////////////////////////////
    @IBOutlet weak var cardsetNameOutlet: UITextField!
    @IBOutlet weak var cardsetShortOutlet: UITextField!

    @IBOutlet weak var sideOneOutlet: UITextField!
    @IBOutlet weak var sideTwoOutlet: UITextField!
    
    @IBOutlet weak var cardNumberOutlet: UILabel!
    @IBOutlet weak var doneOutlet: UIButton!
    @IBOutlet weak var previousOutlet: UIButton!
    @IBOutlet weak var nextOutlet: UIButton!
    ///////////////////////////////////////////////////////
    // Fresh home-made functions and variables! By hand! //
    ///////////////////////////////////////////////////////
   
    func updateCardsetProperties() {
        if editSet.cardsInSet > editSet.currentlySelectedFlashyCard || editSet.cardsInSet == 0 {
            if sideOneOutlet.text != "" && sideTwoOutlet.text != "" {
                editSet.generateNewCard(sideOneOfCard: sideOneOutlet.text!, sideTwoOfCard: sideTwoOutlet.text!)
                sideTwoOutlet.placeholder = "Card side 1"
                sideTwoOutlet.placeholder = "Card side 2"
                nextOutlet.hidden = false
                previousOutlet.hidden = false
                doneOutlet.hidden = false
                // If something is in the text fields, show all buttons and append the two text boxes to the edit set which will be written to the currently selected set.
            } else {
                sideTwoOutlet.placeholder = "You need something here"
                sideTwoOutlet.placeholder = "You need something here"
                nextOutlet.hidden = false
                previousOutlet.hidden = false
                doneOutlet.hidden = false
            }
        } else if editSet.cardsInSet <= editSet.currentlySelectedFlashyCard {
            print("updateCardsetProperties: Second if chosen.")
            // If the selected "card" is within the range, preform the following. This is an if/else because generateNewFlashyCard
            if let text = sideOneOutlet.text {
                editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideOne = text
            } // Just an if let because sideOneOutlet.text is a string optional
            if let text = sideTwoOutlet.text {
                editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideTwo = text
            } // See above comment
            // If either of these are nil, nothing will happen and the previous side 1/2 will remain.
            
            print("Modified \(editSet.name), card \(editSet.currentlySelectedFlashyCard)")
        }
        editSet.name = cardsetNameOutlet.text
        // Both optionals so who cares
        
        if let text = cardsetShortOutlet.text {
            editSet.shortName = text
            doneOutlet.hidden = false
        } else {
            cardsetShortOutlet.placeholder = "We need something here."
            doneOutlet.hidden = true
        }
        if let title = self.title {
            print("Updated card values \(title)")
        } else {
            print("Updated card values for view with nil title (name it!)")
        }
    }
    
    func updateValuesInView() {
        ////////////////////////////////////////
        // Update text according to variables //
        ////////////////////////////////////////
        if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == (currentlySelectedFlashyCardset.cardsInSet) && currentlySelectedFlashyCardset.currentlySelectedFlashyCard == 0 {
            nextOutlet.hidden = true
            previousOutlet.hidden = true
            // If the selected card is equal to the cards in set +1 (because .count starts with 1), AND the currently selected index is [0]: show the next and previous button.
        } else if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == (currentlySelectedFlashyCardset.cardsInSet) {
            nextOutlet.hidden = true
            previousOutlet.hidden = false
            // If the currently selected card index value is equal to the cards in set +1 (because .count starts with 1), then hide the next button and show the previous button.
        } else if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == 0 {
            previousOutlet.hidden = true
            nextOutlet.hidden = false
            // If we are at index value 0, hide the previous button and show the next.
        } else {
            nextOutlet.hidden = false
            previousOutlet.hidden = false
        }
        
        // Now we handle the card counter
        cardNumberOutlet.text = "Card #\(currentlySelectedFlashyCardset.currentlySelectedFlashyCard+1)"

        ///////////////////////////
        // Updating color scheme //
        ///////////////////////////
        if let cardsetName = currentlySelectedFlashyCardset.name {
            cardsetNameOutlet.attributedPlaceholder = NSAttributedString(string: cardsetName,attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.headerColor])
        } else {
            cardsetNameOutlet.attributedPlaceholder = NSAttributedString(string: "Name the cardset!",attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.headerColor])
        } // Making sure that there is not already a name for the cardset then setting.
        cardsetNameOutlet.textColor = currentlySelectedColorScheme.headerColor
        cardsetNameOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        cardsetShortOutlet.attributedPlaceholder = NSAttributedString(string: currentlySelectedFlashyCardset.shortName, attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.highlightColor])
        cardsetShortOutlet.textColor = currentlySelectedColorScheme.highlightColor
        cardsetShortOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        // Sets the shortname to whatever the currently selected set's sn is (non optional)
        
        if currentlySelectedFlashyCardset.currentlySelectedFlashyCard > currentlySelectedFlashyCardset.cardsetArray.count || currentlySelectedFlashyCardset.cardsetArray.count == 0 {
            
            sideOneOutlet.attributedPlaceholder = NSAttributedString(string: "Enter side one of the card!", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.highlightColor])
            
            sideTwoOutlet.attributedPlaceholder = NSAttributedString(string: "Enter side two of the card!", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.highlightColor])
            // If the index of the card you are modifying is greater than the amount of cards in the set, or the amount of cards in the set is 0, do this. Otherwise, fall to the else statment.
        } else {
            sideOneOutlet.attributedPlaceholder = NSAttributedString(string: currentlySelectedFlashyCardset.cardsetArray[currentlySelectedFlashyCardset.currentlySelectedFlashyCard].sideOne, attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.textColor])
            
            sideTwoOutlet.attributedPlaceholder = NSAttributedString(string: currentlySelectedFlashyCardset.cardsetArray[currentlySelectedFlashyCardset.currentlySelectedFlashyCard].sideTwo, attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.textColor])
            // Sets the card's text to the text of the selected FlashyCard
        }
        sideOneOutlet.textColor = currentlySelectedColorScheme.highlightColor
        sideOneOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
    
        sideTwoOutlet.textColor = currentlySelectedColorScheme.highlightColor
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
        
        if let title = self.title {
            print("Updated values for \(title)")
        } else {
            print("Updated values for view with nil title (name it!)")
        }
    }
    
    //////////////////////////
    // The viewDidLoad func //
    //////////////////////////
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        forceEquivilency(setToBeWritten: editSet, setToBeRead: currentlySelectedFlashyCardset)
        cardsetNameOutlet.delegate = self
        cardsetShortOutlet.delegate = self
        sideOneOutlet.delegate = self
        sideTwoOutlet.delegate = self
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        updateValuesInView()
        updateCardsetProperties()
    }
    
    ////////////////////////////////////////////////////////////////
    // Get your brand new IBAction functions here! (and the like) //
    ////////////////////////////////////////////////////////////////
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        self.view.endEditing(true)
        updateCardsetProperties()
        return false
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        updateCardsetProperties()
    }
    
    @IBAction func doneAction() {
        // Pressed the done button
        let alert = UIAlertController(title: "Hold on!", message: "Would you like to save and quit the flashcard set? This will override what is currently in \(currentlySelectedFlashyCardset.name)", preferredStyle: UIAlertControllerStyle.Alert)
            // Makes the body for an alert.
        
        // add the actions (buttons)
        // The "go" button
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { action in
            
            forceEquivilency(setToBeWritten: currentlySelectedFlashyCardset, setToBeRead: editSet)
            self.performSegueWithIdentifier("editorToMainSegue", sender: nil)
        }))
        
        // The cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
       
    }
    
    @IBAction func previousAction() {
    }
    
    @IBAction func nextAction() {
    }
    
    
}

