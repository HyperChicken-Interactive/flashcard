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
    @IBOutlet weak var cardsetLabel: UILabel!
    // The label at the top of the view that has the default text of  "Cardset Name"
    @IBOutlet weak var cardNumberLabel: UILabel!
    // The Label below the card itself that says by default "Card ##/##"
    @IBOutlet weak var flashyCardText: UILabel!
    // The actual card.
    
    @IBOutlet weak var flipOutlet: UIButton!
    // The flip button
    @IBOutlet weak var quitOutlet: UIButton!
    // The quit button
    @IBOutlet weak var randomOutlet: UIButton!
    // The random button
    
    
    @IBOutlet weak var nextFlashyOutlet: UIButton!
    // An outlet for the "next" button. See nextFlashyButton() for the method that is triggered on press.
    @IBOutlet weak var previousFlashyOutlet: UIButton!
    // An outlet for the "previous" button. See previousFlashyButton() for the method that is triggered on press.
    
    ///////////////////////////////
    // Homemade methods and vars //
    ///////////////////////////////
    
    func updateValuesInView(){
        // This function updates all of the values in the view, like making sure the buttons are hidden if they need to be or the text is proper
        if currentlySelectedFlashyCard == (currentlySelectedFlashyCardset.cardsInSet-1) {
            nextFlashyOutlet.hidden = true
            previousFlashyOutlet.hidden = false
        } else if currentlySelectedFlashyCard == 0 {
            previousFlashyOutlet.hidden = true
            nextFlashyOutlet.hidden = false
        } else if currentlySelectedFlashyCard == (currentlySelectedFlashyCardset.cardsInSet-1) && currentlySelectedFlashyCard == 0 {
            nextFlashyOutlet.hidden = true
            previousFlashyOutlet.hidden = true
        } else {
            nextFlashyOutlet.hidden = false
            previousFlashyOutlet.hidden = false
        }
        // Makes the next or previous buttons hidden if the currentlySelectedFlashyCard is at the highest index value or the lowest index value of currentlySelectedFlashyCardset.
        
        cardNumberLabel.text = "Card \(currentlySelectedFlashyCard+1)/\(currentlySelectedFlashyCardset.cardsInSet)"
        if let cardsetName = currentlySelectedFlashyCardset.name {
            cardsetLabel.text = cardsetName
        } else {
            cardsetLabel.text = "You really should name this set!"
        }
        // Changes the cardsetLabel to the name of the cardset. If that fails, then it changes the label to say "You really should name this set!"
        
        flashyCardText.text = currentlySelectedFlashyCardset.cardsContained[currentlySelectedFlashyCard].currentlySelectedSide
        
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
        
    }
    
    
    var currentlySelectedFlashyCard = 0
    
    ///////////////////
    // viewDidLoad() //
    ///////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentlySelectedFlashyCardset.generateNewCard(sideOneOfCard: "This is card 1, side 1", sideTwoOfCard: "This is card 1, side 2")
        currentlySelectedFlashyCardset.generateNewCard(sideOneOfCard: "This is card 2, side 1", sideTwoOfCard: "This is card 2, side 2")
        currentlySelectedFlashyCardset.generateNewCard(sideOneOfCard: "This is card 3, side 1", sideTwoOfCard: "This is card 3, side 2")
        
        currentlySelectedFlashyCardset.cardsContained = currentlySelectedFlashyCardset.cardsetArray
        // This is shit code and I know it, will be rectified along with other, simmilar problems in v4.0-alpha.
        
        print("FlashyCard operation centre view loaded")
        print("Generated 3 cards for default set.")
        
        updateValuesInView()
    }
    
    ////////////////
    // IB Actions //
    ////////////////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func generateRandomized() {
        //The method relating to the "flip" button.
        print("Random button pressed")
        currentlySelectedFlashyCardset.cardsContained = currentlySelectedFlashyCardset.randomizeCardSets()
        // Gens a new cardset from .randomizeCardSets()
        currentlySelectedFlashyCard = 0
        // Sets the selected card to 0
        updateValuesInView()
        // Updates values and frames.
    }
    
    @IBAction func flipFlashyButton() {
        // The method relating to the "flip" button.
        print("Flipped Card!")
        currentlySelectedFlashyCardset.cardsContained[currentlySelectedFlashyCard].flipCard()
        // When pressed, this button will preform the flipCard() method on the currently selected card along with printing that this action occured to the log.
        updateValuesInView()
    }
    
    @IBAction func nextFlashyButton() {
        // The method relating to the "next" button. See nextFlashyOutlet for the outlet.
        print("Next button pressed")
        currentlySelectedFlashyCard += 1
        updateValuesInView()
    }
    
    @IBAction func previousFlashyButton() {
        // The method relating to the "previous" button. See previousFlashyOutlet for the outlet.
        print("Previous button pressed")
        currentlySelectedFlashyCard -= 1
        updateValuesInView()
    }
}

// For changing the views attributes manually
// myLabel.adjustsFontSizeToFitWidth = true