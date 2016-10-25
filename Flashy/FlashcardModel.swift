//
//  FlashcardModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/1/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

// The structs and god knows what for modeling the flashcards.

import Foundation

struct FlashyCard {
    var sideOne: String
    var sideTwo: String
    var currentlySelectedSide: String
    mutating func flipCard() {
        switch currentlySelectedSide {
        case sideOne:
            currentlySelectedSide = sideTwo
        case sideTwo:
            currentlySelectedSide = sideOne
        default:
            print("welcome to the 4th dimention, i'll be your guide.")
            print("Tried to flip card. Failed?")
        }
    }
    init(sideOne: String, sideTwo: String) {
        self.sideOne = sideOne
        self.sideTwo = sideTwo
        self.currentlySelectedSide = sideOne
    }
} // a card object with two sides, and a selected side. The flip function switches what side of the card will be visable.

struct FlashySet {
    var name: String?
    // You did handle the optional asshat.
    
    var shortName: String = "Blank"
    // Short name to be used on the picker.
    
    ///Checks to see if this is either the default set or an edit set. Those are two special sets that are ignored when saving to a file.
    let isIgnored: Bool
    
    /// A unique identifying integer, used primarily in saving the files.
    let uniqueID: Int?
    
    var currentlySelectedFlashyCard = 0
    
    /// cardsetArray is an array of FlashyCard custom data type. It is the sequential list of cards in the set.
    var cardsetArray: [FlashyCard]
    
    /// Cards contained is an array of FlashyCard custom data type. It has been modified to be more of a pointer to either a randomized cardset or the original sequential one of cardsetArray.
    var cardsContained: [FlashyCard]
    
    var cardsInSet: Int{
        return self.cardsetArray.count
    } // Number of cards in set for the Next and Prev buttons.
    
    init(nameOfFlashcardSet n: String?, shortNameOfSet s: String?, isIgnored su: Bool){
        if let name = n {
            self.name = name
        }
        if let sn = s {
            self.shortName = sn
        }
        cardsetArray = []
        cardsContained = cardsetArray
        self.isIgnored = su
        
        if su == false {
            self.uniqueID = idMarker
            idMarker += 1
        } else {
            self.uniqueID = nil
        }
    }
    
    mutating func generateNewCard(sideOneOfCard s1: String, sideTwoOfCard s2: String) {
        self.cardsetArray.append(FlashyCard(sideOne: s1, sideTwo: s2))
        // Will take in card strings provided by user and cast them into FlashyCards.
    }
    
    /// Forces equivilency between "tbr", which is the set to be cloned, and self. Used when "saving" edit set.
    mutating func forceEquivilency(setToBeRead tbr: FlashySet) {
        
        self.name = tbr.name
        self.shortName = tbr.shortName
        self.cardsetArray = tbr.cardsetArray
        self.cardsContained = tbr.cardsContained
        print("Forced equivilency between \(self) and \(tbr) where \(self) was written to.")
    }

    func randomizeCardSets() -> [FlashyCard]{
        
        var shuffledSetOfFlashyCards: [FlashyCard] = []
        // This array, while currently empty will be returned.
        
        var arrayOfAlreadyUsedCards: [Int] = []
        // I will use this array in the while loop to determine cards already in the shuffled set.
        
        while shuffledSetOfFlashyCards.count != cardsInSet {
            // Under no circumstances are you to change the above line. It pains me to say this but "It just works don't touch it"
            let randomNumber = Int(arc4random_uniform(UInt32(cardsInSet)))
            // Gen random number to be used in this braket level
            // Error was "cardsInSet+1" should have just been "cardsInSet"
            
            if arrayOfAlreadyUsedCards.contains(randomNumber) != true {
                shuffledSetOfFlashyCards.append(self.cardsetArray[randomNumber])
                arrayOfAlreadyUsedCards.append(randomNumber)
                // If randomNumber is indeed in arrayOfAlreadyUsedCards and hence, in shuffledSetOfFlashyCards, ignore it and try again. There is probably some .shuffle method Apple uses for this particular reson but where's the fun in that?
            }
            
        }
        
        return shuffledSetOfFlashyCards
        //Now that shuffledSetOfFlashyCards has the full contents of self.cardsetArray, we can return it.
    }
}

// Creating child classes for the actual sets.

var flashySuper: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil, isIgnored: true)

var set01: FlashySet = FlashySet(nameOfFlashcardSet: "Flashy Set Example #1", shortNameOfSet: "Example 1", isIgnored: false)
var set02: FlashySet = FlashySet(nameOfFlashcardSet: "Flashy Set Example #2", shortNameOfSet: "Example 2", isIgnored: false)
var set03: FlashySet = FlashySet(nameOfFlashcardSet: "Flashy Set Example #3", shortNameOfSet: "Example 3", isIgnored: false)
var set04: FlashySet = FlashySet(nameOfFlashcardSet: "Flashy Set Example #4", shortNameOfSet: "Example 4", isIgnored: false)
var set05: FlashySet = FlashySet(nameOfFlashcardSet: "Flashy Set Example #5", shortNameOfSet: "Example 5", isIgnored: false)

var editSet: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil, isIgnored: true)

var flashySetArray: [FlashySet] = []





