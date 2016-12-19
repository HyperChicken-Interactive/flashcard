//
//  FlashcardModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/1/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

// The structs and god knows what for modeling the flashcards.

import Foundation


/** 
 # Flashcards!
 
 The one-and-only flashcard! It's cool, hip, magical, and a massive pain-in-the-arse!
 
 ## Contents:
 
 1 (one) sideOne of type string. When the user "flashes" their cardset, this is the first side of the card that will show.
 1 (one) sideTwo of type string. This is the opposite side to sideOne.
 1 (one) currentlySelectedSide of type string. It "points" to either sideOne or sideTwo.
 1 (one) mutating flipCard function. Sets the value of currentlySelectedSide to sideTwo if it's sideOne or sideOne if it's sideTwo
 1 (one) custom init method.
 
 2 (two) NSCoding/NSKeyed​Archiver methods that I shamelessly stole from NSHipster.
 */
class FlashyCard: NSObject, NSCoding {
    var sideOne: String
    var sideTwo: String
    var currentlySelectedSide: String
    func flipCard() {
        switch currentlySelectedSide {
        case sideOne:
            currentlySelectedSide = sideTwo
            loginfo(infoText: "Flipped flashycard", fileOccured: nil, objectRunIn: "mutating func flipCard()", otherInfo: ["Flipped from card \(sideOne) to \(sideTwo).", "The currently selected card is \(self.currentlySelectedSide).", "Side one is: \" \(sideOne) \".", "Side two is: \" \(sideTwo) \"."])
        case sideTwo:
            currentlySelectedSide = sideOne
            loginfo(infoText: "Flipped flashycard", fileOccured: nil, objectRunIn: "mutating func flipCard()", otherInfo: ["Flipped from card \(sideTwo) to \(sideOne).", "The currently selected card is \(self.currentlySelectedSide).", "Side one is: \" \(sideOne) \".", "Side two is: \" \(sideTwo) \"."])
        default:
            loginfo(infoText: "Flipped flashycard. Failed.", fileOccured: nil, objectRunIn: "mutating func flipCard()", otherInfo: ["Tried to flip from card \(self.currentlySelectedSide).", "The currently selected card is \(self.currentlySelectedSide).", "Side one is: \" \(sideOne) \".", "Side two is: \" \(sideTwo) \"."])
        }
    }
    init(sideOne: String, sideTwo: String) {
        self.sideOne = sideOne
        self.sideTwo = sideTwo
        self.currentlySelectedSide = sideOne
    }
    
    /////
    
    required convenience init?(coder decoder: NSCoder) {
        guard let sideOne = decoder.decodeObject(forKey: "sideOne") as? String,
            let sideTwo = decoder.decodeObject(forKey: "sideTwo") as? String
            else { return nil }
        
        self.init(
            sideOne: sideOne,
            sideTwo: sideTwo
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.sideOne, forKey: "sideOne")
        coder.encode(self.sideTwo, forKey: "sideTwo")
    }
}

/**
 # The meaning of life, the universe, and everything.
 
 This was in theory, meant to be an array of [FlashyCard], but we can't have nice things so I've made it into an absurd, structy, thing. I've tried to document all of the important bits, but please open an issue on Git if you don't understand something.
 */
class FlashySet: NSObject, NSCoding {
        
    /** Name of Flashy set.
     Very important and whatnot. As of v4.0-alpha, build 14, this replaces the shortname field.
     If you're not Whitman and reading this. All logic has been updated accordingly and tested as much as can be done.
     
     **TODO:** Update when fully reformed.
     */
    var name: String
     
    /** I can't think of a better name for this.
     This is a value to indicate wether the set this vale is a member of is either the edit set or the superset.
     
     Usage: This instance is used in the menu to see if the selected set is the default superset. When the default set is selected and an attempt to move to the preference view is made, a new cardset is appended to
    */
    let isIgnored: Bool
    
    /// The currently selected card. This value can be changes but will always be 0 by default. It's value is not archived.
    var currentlySelectedFlashyCard = 0
    
    /// cardsetArray is an array of FlashyCard custom data type. It is the sequential list of cards in the set.
    var cardsetArray: [FlashyCard]
    
    /// Cards contained is an array of FlashyCard custom data type. It has been modified to be more of a pointer to either a randomized cardset or the original sequential one of cardsetArray.
    var cardsContained: [FlashyCard]
    
    /// A pseudonym for the "count" of .cardsetArray
    var cardsInSet: Int{
        return self.cardsetArray.count
    }
    /// Number of cards in set for the Next and Prev buttons.
    
    init(isInitializedViaEncoder ive: Bool, nameOfFlashcardSet n: String?, isIgnored su: Bool, cardsInSet csa: [FlashyCard]?){
        
        if let nm = n {
            self.name = nm
            loginfo(infoText: "Name property initialized", fileOccured: nil, objectRunIn: "FlashySet.init()", otherInfo: ["Given property: \(name)"])
        } else {
            loginfo(infoText: "CRITICAL: Name property failed to initialize", fileOccured: nil, objectRunIn: "FlashySet.init()", otherInfo: ["For safty precautions, the shortname has been changed to an empty string."])
            self.name = ""
        }
        
        self.isIgnored = su
        
        if ive == false {
            
            cardsetArray = []
            cardsContained = cardsetArray
            
        } else {
            self.cardsetArray = csa!
            self.cardsContained = cardsetArray
        }
    }
    
    func generateNewCard(sideOneOfCard s1: String, sideTwoOfCard s2: String) {
        self.cardsetArray.append(FlashyCard(sideOne: s1, sideTwo: s2))
        // Will take in card strings provided by user and cast them into FlashyCards.
    }
    
    /** ## Forces equivilency between two sets
     
 This function attempts to force equivilency between "tbr", which is the set to be cloned, and self. Used when "saving" (**NOT** ARCHIVING) edit set to the original.
     
 - parameter tbr: The cardset that will be cloned and written to self.
 - parameter frf: The file this function is run from. Use for debugging.
     */
    func forceEquivilency(setToBeRead tbr: FlashySet, fileRunFrom frf: String?) {
        loginfo(infoText: "Attempting to force equivilency between \(tbr.name) and \(self.name)", fileOccured: frf, objectRunIn: "forceEquivilency", otherInfo: nil)
        self.name = tbr.name
        self.cardsetArray = tbr.cardsetArray
        self.cardsContained = tbr.cardsetArray
        loginfo(infoText: "Forced equivilency succeded.", fileOccured: frf, objectRunIn: "forceEquivilency", otherInfo: nil)
    }
    
    /** ## Ransomizes cards within set.
 This function randomizes the cards in `self`'s set for flashing (//TODO: find a better word than "flashing"). This is usually assosiated with cardsContained, which is the actual array displayed when flashing.
 - returns: The reorganized array.
    */
    func randomizeCardSets() -> [FlashyCard]{
        
        /// The array that will be inevitably returned.
        var shuffledSetOfFlashyCards: [FlashyCard] = []
        
        /// The list of cards already in `shuffledSetOfFlashyCards`. This prevents duplicates.
        var arrayOfAlreadyUsedCards: [Int] = []
        
        while shuffledSetOfFlashyCards.count != cardsInSet {
            
            /**
             Generates a random number between 0...cardsInSet (A.K.A. the .count value of cardsetArray)
             
             PREVIOUS KNOWN ERRORS:
             - Undated, nonissued, error regarding a problem wherin the integer generated was between 0...(cardsInSet+1), causing out-of-range crashes. This was fixed by making it cardsInSet. (NOTE: This code and the comment this bug notice was based on is extremly old (pre v1.0-alpha). I do not know why I may have commented that down, but it seemed to be important. I trust my previous self.)
             */
            let randomNumber = Int(arc4random_uniform(UInt32(cardsInSet)))
            
            // If randomNumber is indeed in arrayOfAlreadyUsedCards and hence, in shuffledSetOfFlashyCards, ignore it and try again. There is probably some .shuffle method Apple uses for this particular reson but where's the fun in that?
            if arrayOfAlreadyUsedCards.contains(randomNumber) != true {
                shuffledSetOfFlashyCards.append(self.cardsetArray[randomNumber])
                arrayOfAlreadyUsedCards.append(randomNumber)
            }
            
        }
        
        return shuffledSetOfFlashyCards
        //Now that shuffledSetOfFlashyCards has the full contents of self.cardsetArray, we can return it.
    }
    
    // Below is code directly copied and pasted from NSHipter with some name changes in terms of variables. I have no shame.
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String,
            let cardsetArray = decoder.decodeObject(forKey: "cardsetArray") as? [FlashyCard]
            else { return nil }
        
        self.init(
            isInitializedViaEncoder: true,
            nameOfFlashcardSet: name,
            isIgnored: decoder.decodeBool(forKey: "isIgnored"),
            cardsInSet: cardsetArray
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(true, forKey: "initializedViaEncoder")
        coder.encode(self.cardsetArray, forKey: "cardsetArray")
        coder.encode(self.isIgnored, forKey: "isIgnored")
    }
}

/**zz
 ## Iterates Values in Flashcard array
 
 I'll be honest, I haven't the faintest on how to make this generic. I should, but I'm trash.
 - returns: Array of all names in the set.
 */
func iterateCardsetShortnames() -> [String] {
    var returnedArray: [String] = ["New Set"]
    for card in (flashySetArray){
        returnedArray.append(card.name)
    }
    return returnedArray
}

// Creating child classes for the actual sets.

let flashySuper: FlashySet = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: "Click \"new\" to create a new set", isIgnored: true, cardsInSet: nil)

var editSet: FlashySet = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: nil, isIgnored: true, cardsInSet: nil)

let blankSet: FlashySet = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: "", isIgnored: true, cardsInSet: nil)

/**
 ## The array of ALL custom-made flashysets.
 
 This is the array of all **custom-made** cardsets. Meaning the editset and original cardset are not included. This cardset will be what is stored when the app closes.
 */
var flashySetArray: [FlashySet] = returnFlashySets()
