//
//  ViewController.swift
//  Flashy
//
//  Created by Whitman Huntley on 7/27/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

class FlashViewController: UIViewController {
    
    ////////////////
    // IB Outlets //
    ////////////////
    
    /// The label at the top of the view that displays the cardset name
    @IBOutlet weak var cardsetLabel: UILabel!
    
    /// The Label below the card itself that says by default "Card ##/##"
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    /// The actual card.
    @IBOutlet weak var flashyCardText: UILabel!
    
    /// The flip button
    @IBOutlet weak var flipOutlet: UIButton!
    
    /// The quit button
    @IBOutlet weak var quitOutlet: UIButton!
    
    /// The random button
    @IBOutlet weak var randomOutlet: UIButton!
    
    /// An outlet for the "next" button. See nextFlashyButton() for the method that is triggered on press.
    @IBOutlet weak var nextFlashyOutlet: UIButton!
    
    /// An outlet for the "previous" button. See previousFlashyButton() for the method that is triggered on press.
    @IBOutlet weak var previousFlashyOutlet: UIButton!
    
    ///////////////////////////////
    // Homemade methods and vars //
    ///////////////////////////////
    
    func updateValuesInView(){
        // This function updates all of the values in the view, like making sure the buttons are hidden if they need to be or the text is proper
        if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == (currentlySelectedFlashyCardset.cardsInSet-1) && currentlySelectedFlashyCardset.currentlySelectedFlashyCard == 0 {
            // Check if new set (Card selected is both card 0 and the highest card.)
            nextFlashyOutlet.isHidden = true
            previousFlashyOutlet.isHidden = true
            loginfo(infoText: "There are currently 0 cards in the set. Hiding next and previous buttons.", fileOccured: "FlashViewController.swift", objectRunIn: "UpdateValuesInView()", otherInfo: ["There are actually \(currentlySelectedFlashyCardset.cardsInSet) card(s).", "When calculated, it shows there are \(currentlySelectedFlashyCardset.cardsInSet-1) cards."])
        
        } else if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == 0 {
            // Evaluates if at card #0, but there are other cards in the set.
            previousFlashyOutlet.isHidden = true
            nextFlashyOutlet.isHidden = false
            loginfo(infoText: "The currently selected card is #0. Hiding the previous button.", fileOccured: "FlashViewController.swift", objectRunIn: "UpdateValuesInView()",
                    otherInfo: ["There are actually \(currentlySelectedFlashyCardset.cardsInSet) card(s).",
                "When calculated, it shows there are \(currentlySelectedFlashyCardset.cardsInSet-1) cards.",
                "The currently selected card is \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard)."])
            
        } else if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == (currentlySelectedFlashyCardset.cardsInSet-1) {
            nextFlashyOutlet.isHidden = true
            previousFlashyOutlet.isHidden = false
            loginfo(infoText: "Maximum cards reached. Hiding the next button", fileOccured: "FlashViewController.swift", objectRunIn: "UpdateValuesInView()", otherInfo: ["There are actually \(currentlySelectedFlashyCardset.cardsInSet) card(s).", "When calculated, it shows there are \(currentlySelectedFlashyCardset.cardsInSet-1) cards.", "The currently selected card is \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard)."])
        } else {
            nextFlashyOutlet.isHidden = false
            previousFlashyOutlet.isHidden = false
            loginfo(infoText: "Currently selected card is neither 0 or the last card in set. Showing all buttons.", fileOccured: "FlashViewController.swift", objectRunIn: "UpdateValuesInView()", otherInfo: ["There are actually \(currentlySelectedFlashyCardset.cardsInSet) card(s).",
                "When calculated, it shows there are \(currentlySelectedFlashyCardset.cardsInSet-1) cards.",
                "The currently selected card is \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard)."])
        }
        // Makes the next or previous buttons hidden if the currentlySelectedFlashyCard is at the highest index value or the lowest index value of currentlySelectedFlashyCardset.
        
        cardNumberLabel.text = "Card \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard+1)/\(currentlySelectedFlashyCardset.cardsInSet)"
        
        cardsetLabel.text = currentlySelectedFlashyCardset.name
        
        flashyCardText.text = currentlySelectedFlashyCardset.cardsContained[currentlySelectedFlashyCardset.currentlySelectedFlashyCard].currentlySelectedSide
        
        // Now to do massive updates on the color scheme!
        cardsetLabel.textColor = currentlySelectedColorScheme.headerColor
        cardsetLabel.backgroundColor = currentlySelectedColorScheme.boxColor
        
        cardNumberLabel.textColor = currentlySelectedColorScheme.textColor
        cardNumberLabel.backgroundColor = currentlySelectedColorScheme.boxColor
        
        flashyCardText.textColor = currentlySelectedColorScheme.textColor
        flashyCardText.backgroundColor = currentlySelectedColorScheme.boxColor
        
        previousFlashyOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        previousFlashyOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        nextFlashyOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        nextFlashyOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        flipOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        flipOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        quitOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        quitOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        randomOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        randomOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        
        view.backgroundColor = currentlySelectedColorScheme.backgroundColor
        
        loginfo(infoText: "Updated values in view", fileOccured: "FlashyViewController.swift", objectRunIn: "updateValuesInView()", otherInfo: nil)

    }
    
    ///////////////////
    // viewDidLoad() //
    ///////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentlySelectedFlashyCardset.cardsContained = currentlySelectedFlashyCardset.cardsetArray
        // This is poor code and I know it, will be rectified along with other, simmilar problems during the mass refactoring.
        
        updateValuesInView()
        loginfo(infoText: "View loaded successfully", fileOccured: "FlashViewController.swift", objectRunIn: title, otherInfo: nil)
    }
    
    ////////////////
    // IB Actions //
    ////////////////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        loginfo(infoText: "CRITICAL: A memory warning was recived", fileOccured: "FlashViewController.swift", objectRunIn: nil, otherInfo: nil)
    }

    @IBAction func generateRandomized() {
        //The method relating to the "flip" button.
        print("Random button pressed")
        currentlySelectedFlashyCardset.cardsContained = currentlySelectedFlashyCardset.randomizeCardSets()
        // Gens a new cardset from .randomizeCardSets()
        currentlySelectedFlashyCardset.currentlySelectedFlashyCard = 0
        // Sets the selected card to 0
        updateValuesInView()
        // Updates values and frames.
    }
    
    @IBAction func flipFlashyButton() {
        // The method relating to the "flip" button.
        loginfo(infoText: "Flip Card button pressed", fileOccured: "FlashViewController.swift", objectRunIn: title, otherInfo: nil)
        currentlySelectedFlashyCardset.cardsContained[currentlySelectedFlashyCardset.currentlySelectedFlashyCard].flipCard()
        // When pressed, this button will preform the flipCard() method on the currently selected card along with printing that this action occured to the log.
        updateValuesInView()
    }
    
    @IBAction func nextFlashyButton() {
        // The method relating to the "next" button. See nextFlashyOutlet for the outlet.
        loginfo(infoText: "Previous Card button pressed", fileOccured: "FlashViewController.swift", objectRunIn: title, otherInfo: ["The currently selected card *IS* \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard)",
            "The currently selected card *WILL BE* \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard+1)"])
        
        currentlySelectedFlashyCardset.currentlySelectedFlashyCard += 1
        
        loginfo(infoText: "Successfully transitioned to next card", fileOccured: "FlashViewController.swift", objectRunIn: title, otherInfo: nil)
        
        updateValuesInView()
    }
    
    @IBAction func previousFlashyButton() {
        // The method relating to the "previous" button. See previousFlashyOutlet for the outlet.
        loginfo(infoText: "Previous Card button pressed", fileOccured: "FlashViewController.swift", objectRunIn: title, otherInfo: ["The currently selected card *IS* \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard)",
            "The currently selected card *WILL BE* \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard-1)"])
        
        currentlySelectedFlashyCardset.currentlySelectedFlashyCard -= 1
        
        loginfo(infoText: "Successfully transitioned to previous card", fileOccured: "FlashViewController.swift", objectRunIn: title, otherInfo: nil)
        
        updateValuesInView()
    }
}

// For changing the views attributes manually
// myLabel.adjustsFontSizeToFitWidth = true
