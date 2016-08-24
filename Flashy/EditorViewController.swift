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
        
        print("Side one text is \"\(sideOneOutlet.text!)\"")
        print("Side two text is \"\(sideTwoOutlet.text!)\"")
        print("Shortname text is \"\(cardsetShortOutlet.text!)\"")
        
        if editSet.cardsInSet == 0 {
            nextOutlet.hidden = true
            previousOutlet.hidden = true
            // If we're on the first card that is to be genned for a new set, hide the next and previous buttons. The done button will be handled seperately.
        } else if editSet.currentlySelectedFlashyCard == (editSet.cardsInSet) {
            nextOutlet.hidden = true
            previousOutlet.hidden = false
            // If the currently selected card index value is equal to the cards in set +1 (because .count starts with 1), then hide the next button and show the previous button.
        } else if editSet.currentlySelectedFlashyCard == 0 {
            previousOutlet.hidden = true
            nextOutlet.hidden = false
            // If we are at index value 0, hide the previous button and show the next.
        } else {
            nextOutlet.hidden = false
            previousOutlet.hidden = false
        }
        
        if editSet.cardsInSet < editSet.currentlySelectedFlashyCard || editSet.cardsInSet == 0 {
            // If the # of cards in set is greater than the currently selected card or if it is 0.
            if sideOneOutlet.text?.isEmpty == false && sideTwoOutlet.text?.isEmpty == false {
                print("WHY DOES IT ALWAYS FALLTHROUGH?!?")
                editSet.generateNewCard(sideOneOfCard: sideOneOutlet.text!, sideTwoOfCard: sideTwoOutlet.text!)
                sideTwoOutlet.placeholder = "Enter side one of the card!"
                sideTwoOutlet.placeholder = "Enter side two of the card!"
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
        } else if editSet.cardsInSet >= editSet.currentlySelectedFlashyCard {
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
        //LOOK AT THIS SHIT.
        if cardsetShortOutlet.text!.isEmpty == false {
            editSet.shortName = cardsetShortOutlet.text!
            doneOutlet.hidden = false
        } else {
            doneOutlet.hidden = true
        }
        
        cardNumberOutlet.text = "Card #\(editSet.currentlySelectedFlashyCard+1)"
        //Shows what card you are on.
        
        ///////////////////////////
        // Updating color scheme //
        ///////////////////////////
        
        cardsetNameOutlet.attributedPlaceholder = NSAttributedString(string: "Name the cardset!",attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.headerColor])
        //
        cardsetNameOutlet.textColor = currentlySelectedColorScheme.headerColor
        cardsetNameOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        // delt with the cardset name
        
        cardsetShortOutlet.attributedPlaceholder = NSAttributedString(string: "Short name", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.highlightColor])
        cardsetShortOutlet.textColor = currentlySelectedColorScheme.highlightColor
        cardsetShortOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        // Sets the shortname to whatever the currently selected set's sn is (non optional)
            
        sideOneOutlet.attributedPlaceholder = NSAttributedString(string: "Enter side one of the card!", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.textColor])
        // Updating side one to say "Enter side one"
            
        sideTwoOutlet.attributedPlaceholder = NSAttributedString(string: "Enter side two of the card!", attributes: [NSForegroundColorAttributeName: currentlySelectedColorScheme.textColor])
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
        
        print(editSet.cardsInSet)
        
        if let title = self.title {
            print("Updated values for \(title)")
        } else {
            print("Updated values for view with nil title (name it!)")
        } // Print updated values for debugging.
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
    }
    
    ////////////////////////////////////////////////////////////////
    // Get your brand new IBAction functions here! (and the like) //
    ////////////////////////////////////////////////////////////////
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        self.view.endEditing(true)
        updateValuesInView()
        return false
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        let alert = UIAlertController(title: "Hold on!", message: "Would you like to save and quit the flashcard set? This will override what is currently in \(currentlySelectedFlashyCardset.name!)", preferredStyle: UIAlertControllerStyle.Alert)
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
        editSet.currentlySelectedFlashyCard -= 1
        print("Previous button pressed")
        updateValuesInView()
    }
    
    @IBAction func nextAction() {
        editSet.currentlySelectedFlashyCard += 1
        print("Next button pressed")
        updateValuesInView()
    }
    
    
}

