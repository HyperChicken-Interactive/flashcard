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
            print("Tried to flip card. Failed?")
        }
    }
    init(sideOne: String, sideTwo: String) {
        self.sideOne = sideOne
        self.sideTwo = sideTwo
        self.currentlySelectedSide = sideOne
    }
} // a card object with two sides, and a selected side. The flip function switches what side of the card will be visable.

class FlashySet {
    var name: String?
    // You did handle the optional asshat.
    
    var shortName: String = "Blank"
    // Short name to be used on the picker.
    
    let isSuper: Bool
    
    var currentlySelectedFlashyCard = 0
    
    /// cardsetArray is an array of FlashyCard custom data type. It is the sequential list of cards in the set.
    var cardsetArray: [FlashyCard]
    
    /// Cards contained is an array of FlashyCard custom data type. It has been modified to be more of a pointer to either a randomized cardset or the original sequential one of cardsetArray.
    var cardsContained: [FlashyCard]
    
    var cardsInSet: Int{
        return self.cardsetArray.count
    } // Number of cards in set for the Next and Prev buttons.
    
    init(nameOfFlashcardSet n: String?, shortNameOfSet s: String?, isSuper su: Bool){
        if let name = n {
            self.name = name
        }
        if let sn = s {
            self.shortName = sn
        }
        cardsetArray = []
        cardsContained = cardsetArray
        self.isSuper = su
    }
    
    func generateNewCard(sideOneOfCard s1: String, sideTwoOfCard s2: String) {
        self.cardsetArray.append(FlashyCard(sideOne: s1, sideTwo: s2))
        // Will take in card strings provided by user and cast them into FlashyCards.
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

class Set01: FlashySet{}
class Set02: FlashySet{}
class Set03: FlashySet{}
class Set04: FlashySet{}
class Set05: FlashySet{}
class EditSet: FlashySet{}
// Creating child classes for the actual sets.

var flashySuper: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil, isSuper: true)

var set01: FlashySet = Set01(nameOfFlashcardSet: "Flashy Set Example #1", shortNameOfSet: "Example 1", isSuper: false)
var set02: FlashySet = Set02(nameOfFlashcardSet: "Flashy Set Example #2", shortNameOfSet: "Example 2", isSuper: false)
var set03: FlashySet = Set03(nameOfFlashcardSet: "Flashy Set Example #3", shortNameOfSet: "Example 3", isSuper: false)
var set04: FlashySet = Set04(nameOfFlashcardSet: "Flashy Set Example #4", shortNameOfSet: "Example 4", isSuper: false)
var set05: FlashySet = Set05(nameOfFlashcardSet: "Flashy Set Example #5", shortNameOfSet: "Example 5", isSuper: false)

var editSet: FlashySet = EditSet(nameOfFlashcardSet: nil, shortNameOfSet: nil, isSuper: false)








