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

class FlashySet: NSObject, NSCoding {
        
    /// Name of Flashy set.
    var name: String?
    
    /// Short name to be used on the picker.
    var shortName: String = "Blank"
     
    ///Checks to see if this is either the default set or an edit set. Those are two special sets that are ignored when saving to a file.
    let isIgnored: Bool
    
    /// A unique identifying integer, used primarily in saving the files.
    let uniqueID: Int?
    
    /// The variable name explains this quite well.
    var currentlySelectedFlashyCard = 0
    
    /// cardsetArray is an array of FlashyCard custom data type. It is the sequential list of cards in the set.
    var cardsetArray: [FlashyCard]
    
    /// Cards contained is an array of FlashyCard custom data type. It has been modified to be more of a pointer to either a randomized cardset or the original sequential one of cardsetArray.
    var cardsContained: [FlashyCard]
    
    var cardsInSet: Int{
        return self.cardsetArray.count
    }
    /// Number of cards in set for the Next and Prev buttons.
    
    init(isInitializedViaEncoder ive: Bool, nameOfFlashcardSet n: String?, shortNameOfSet s: String?, isIgnored su: Bool, cardsInSet csa: [FlashyCard]?, uniqueIdentifier uid: Int?){
        if let name = n {
            self.name = name
        }
        if let sn = s {
            self.shortName = sn
        }
        
        self.isIgnored = su
        
        if ive == false {
            
            cardsetArray = []
            cardsContained = cardsetArray
            
            if su == false {
                self.uniqueID = idMarker
                idMarker += 1
            } else {
                self.uniqueID = nil
            }
        } else {
            self.cardsetArray = csa!
            cardsContained = cardsetArray
            self.uniqueID = uid
        }
    }
    
    func generateNewCard(sideOneOfCard s1: String, sideTwoOfCard s2: String) {
        self.cardsetArray.append(FlashyCard(sideOne: s1, sideTwo: s2))
        // Will take in card strings provided by user and cast them into FlashyCards.
    }
    
    /// Forces equivilency between "tbr", which is the set to be cloned, and self. Used when "saving" edit set.
    func forceEquivilency(setToBeRead tbr: FlashySet) {
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
    
    // Below is code directly copied and pasted from NSHipter, I have no shame.
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String,
            let shortName = decoder.decodeObject(forKey: "shortName") as? String,
            let cardsetArray = decoder.decodeObject(forKey: "cardsetArray") as? [FlashyCard],
            let uid = decoder.decodeObject(forKey: "uniqueID") as? Int!
            else { return nil }
        
        self.init(
            isInitializedViaEncoder: true,
            nameOfFlashcardSet: name,
            shortNameOfSet: shortName,
            isIgnored: decoder.decodeBool(forKey: "isIgnored"),
            cardsInSet: cardsetArray,
            uniqueIdentifier: uid
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(true, forKey: "isInitializedViaEncoder")
        coder.encode(self.shortName, forKey: "shortname")
        coder.encodeCInt(Int32(self.uniqueID!), forKey: "uniqueID")
        coder.encode(self.cardsetArray, forKey: "cardsetArray")
        coder.encode(self.isIgnored, forKey: "isIgnored")
    }
}

/**
 ## Iterates Values in Flashcard array
 
 I'll be honest, I haven't the faintest on how to make this generic. I should, but I'm trash.
 */

func iterateCardsetShortnames() -> [String] {
    var returnedArray: [String] = []
    for card in flashySetArray{
        returnedArray.append(card.shortName)
    }
    return returnedArray
}

// Creating child classes for the actual sets.

var flashySuper: FlashySet = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: "Click edit to create a new set", shortNameOfSet: "New set", isIgnored: true, cardsInSet: [], uniqueIdentifier: nil)

var set01: FlashySet = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: "I'M MR MEMES", shortNameOfSet: "LOOK AT MEMES", isIgnored: false, cardsInSet: [], uniqueIdentifier: nil)

var editSet: FlashySet = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: nil, shortNameOfSet: nil, isIgnored: true, cardsInSet: [], uniqueIdentifier: nil)

/// The array of ALL flashysets. Set01 will be removed, for now, it is here because unit testing is for stupid people
var flashySetArray: [FlashySet] = []


