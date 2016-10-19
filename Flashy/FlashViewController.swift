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
        if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == (currentlySelectedFlashyCardset.cardsInSet-1) {
            nextFlashyOutlet.isHidden = true
            previousFlashyOutlet.isHidden = false
        } else if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == 0 {
            previousFlashyOutlet.isHidden = true
            nextFlashyOutlet.isHidden = false
        } else if currentlySelectedFlashyCardset.currentlySelectedFlashyCard == (currentlySelectedFlashyCardset.cardsInSet-1) && currentlySelectedFlashyCardset.currentlySelectedFlashyCard == 0 {
            nextFlashyOutlet.isHidden = true
            previousFlashyOutlet.isHidden = true
        } else {
            nextFlashyOutlet.isHidden = false
            previousFlashyOutlet.isHidden = false
        }
        // Makes the next or previous buttons hidden if the currentlySelectedFlashyCard is at the highest index value or the lowest index value of currentlySelectedFlashyCardset.
        
        cardNumberLabel.text = "Card \(currentlySelectedFlashyCardset.currentlySelectedFlashyCard+1)/\(currentlySelectedFlashyCardset.cardsInSet)"
        if let cardsetName = currentlySelectedFlashyCardset.name {
            cardsetLabel.text = cardsetName
        } else {
            cardsetLabel.text = "You really should name this set!"
        }
        // Changes the cardsetLabel to the name of the cardset. If that fails, then it changes the label to say "You really should name this set!"
        
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
        
        if let title = self.title {
            print("Updated values for \(title)")
        } else {
            print("Updated values for view with nil title (name it!)")
        } // Prints that is updated values for debugging.

    }
    
    ///////////////////
    // viewDidLoad() //
    ///////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentlySelectedFlashyCardset.cardsContained = currentlySelectedFlashyCardset.cardsetArray
        // This is shit code and I know it, will be rectified along with other, simmilar problems in v4.0-alpha.
        
        print("FlashyCard operation centre view loaded")
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
        currentlySelectedFlashyCardset.currentlySelectedFlashyCard = 0
        // Sets the selected card to 0
        updateValuesInView()
        // Updates values and frames.
    }
    
    @IBAction func flipFlashyButton() {
        // The method relating to the "flip" button.
        print("Flipped Card!")
        currentlySelectedFlashyCardset.cardsContained[currentlySelectedFlashyCardset.currentlySelectedFlashyCard].flipCard()
        // When pressed, this button will preform the flipCard() method on the currently selected card along with printing that this action occured to the log.
        updateValuesInView()
    }
    
    @IBAction func nextFlashyButton() {
        // The method relating to the "next" button. See nextFlashyOutlet for the outlet.
        print("Next button pressed")
        currentlySelectedFlashyCardset.currentlySelectedFlashyCard += 1
        updateValuesInView()
    }
    
    @IBAction func previousFlashyButton() {
        // The method relating to the "previous" button. See previousFlashyOutlet for the outlet.
        print("Previous button pressed")
        currentlySelectedFlashyCardset.currentlySelectedFlashyCard -= 1
        updateValuesInView()
    }
}

// For changing the views attributes manually
// myLabel.adjustsFontSizeToFitWidth = true
