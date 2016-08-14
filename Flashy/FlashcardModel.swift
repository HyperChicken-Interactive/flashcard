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
            panic()
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
    var shortName: String = "Blank"
    var cardsContained: [FlashyCard]
    var cardsInSet: Int{
        return self.cardsContained.count
    }
    
    init(nameOfFlashcardSet n: String?, shortNameOfSet s: String?){
        self.name = n
        if let sn = s {
            self.shortName = sn
        }
        cardsContained = []
    }
    
    mutating func generateNewCard(sideOneOfCard s1: String, sideTwoOfCard s2: String) {
        self.cardsContained.append(FlashyCard(sideOne: s1, sideTwo: s2))
        // Will take in card strings provided by user and cast them into FlashyCards.
    }
    func randomizeCardSets() -> [FlashyCard]{
        
        var shuffledSetOfFlashyCards: [FlashyCard] = []
        // This array, while currently empty will be returned.
        
        var arrayOfAlreadyUsedCards: [Int] = []
        // I will use this array in the while loop to determine cards already in the shuffled set.
        
        while shuffledSetOfFlashyCards.count != cardsInSet {
            // Under no circumstances are you to change the above line. It pains me to say this but "It just works don't touch it"
            let randomNumber = Int(arc4random_uniform(UInt32(cardsInSet+1)))
            // Gen random number to be used in this level
            
            if arrayOfAlreadyUsedCards.contains(randomNumber) != true {
                shuffledSetOfFlashyCards.append(self.cardsContained[randomNumber])
                arrayOfAlreadyUsedCards.append(randomNumber)
                // If randomNumber is indeed in arrayOfAlreadyUsedCards and hence, in shuffledSetOfFlashyCards, ignore it and try again. There is probably some .shuffle method Apple uses for this particular reson but where's the fun in that?
            }
            
        }
        
        return shuffledSetOfFlashyCards
        //Now that shuffledSetOfFlashyCards has the full contents of self.cardsContained, we can return it.
    }
}

var set01: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set02: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set03: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set04: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set05: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set06: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set07: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set08: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set09: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)
var set10: FlashySet = FlashySet(nameOfFlashcardSet: nil, shortNameOfSet: nil)






