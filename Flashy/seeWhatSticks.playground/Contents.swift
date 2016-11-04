//
//  FlashcardModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/1/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

// The structs and god knows what for modeling the flashcards.

import Foundation

func logdata(infoText t: String, fileOccured f: String?, objectRunIn r: String?, otherInfo o: [String]?){
    // I did this the quickest way I can. This should be refactored at all costs before beta or release.
    
    // Getting and formatting the date:
    let date = NSDate()
    let calendar = NSCalendar.current
    
    let year = calendar.component(.year, from: date as Date)
    let month = calendar.component(.month, from: date as Date)
    let day = calendar.component(.day, from: date as Date)
    let hour = calendar.component(.hour, from: date as Date)
    let minutes = calendar.component(.minute, from: date as Date)
    let seconds = calendar.component(.second, from: date as Date)
    
    let nanoInt = calendar.component(.nanosecond, from: date as Date)
    var nanoStr = String(nanoInt)
    for _ in 1...((nanoStr.characters.count)-2) {
        nanoStr = nanoStr.substring(to: nanoStr.index(before: nanoStr.endIndex))
    }
    let nanoseconds = nanoStr
    
    /// The item that will inevitably be printed.
    var toBePrinted: String = ("\(year).\(month).\(day)@\(hour):\(minutes):\(seconds).\(nanoseconds)")
    
    // Adding the info text
    toBePrinted += ": \(t). "
    
    if let file = f {
        toBePrinted += "File: \"\(file)\". "
    }
    if let object = r {
        toBePrinted += "In object: \"\(object)\". "
    }
    if let other = o {
        toBePrinted += "Also:\n"
        for time in other {
            toBePrinted += "  - \(time).\n"
        }
    }
    
    print(toBePrinted)
}

logdata(infoText: "Tested function", fileOccured: "seeWhatSticks.playground", objectRunIn: nil, otherInfo: ["I like trains", "Foo"])

/*

func iterateArrayValues(arrayToBeIteratedOver ar: [Any]) {
    
}

let array1 = ["foo", "bar"]
var array2 = ["baz", "qux"]
array2 += array1

-------------

var idMarker = 1

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


print(set05.uniqueID)

/*-------------------------------------------------------------------*/

/**
 ## Unarcives general settings and cardset unique IDs
 
 The function that **MUST** be run when the app is to become active.
 This function unarchives the currently selected color scheme and the highest version of the unique identifier
 */

func firstUnarchive() {
    let generalFile = "generalSaved.txt"
    let cardsetFile = "uniqueID.txt"
}

/**
 ## Arcives general settings and cardset unique IDs
 
 The function that **MUST** be run when the app is to resign activities.
 This function archives the currently selected color scheme and the highest version of all cardsets unique identifier
 */

func firstArchive(){
    let generalFile = "generalSaved.txt"
    let cardsetFile = "uniqueID.txt"
}

/**
 A function that takes one cardset, and saves it to a file called "flashyset@${UniqueID}.txt". For instance, if the cardset's id was 512, the file would be called flashyset@512.txt.
 
 Due to the fact that we have no idea what we're doing, it will delete the previous file called "flashyset@512.txt" and make a new one with updated data.
 
 All cardsets will run this when the app is being put in the background or when it is closing.
 
 - parameter fcs: The cardset that is acted apon.
 */

func archiveCards(FlashyCardset fcs: FlashySet) {
    
    /// The unique variable that points to the file where it's assosiated flashyset is stored.
    let file = "flashyset@\(fcs.uniqueID).txt"
    
}

/** A function that takes one cardset, and assigns it values as according to the file that shares it's unique identifier.
 
 All cardsets will attempt to run this on app startup.
 
 FirstUnarchive() will fetch the unique identifiers and should ALWAYS WITH NO EXEPTIONS BE RUN **BEFORE** this function is run which is why it won't fail miserably when run.
 
 - parameter gid: The largest unieque identifier.
 */

func unarchiveCards(LargestUniqueID gid: Int){
    for id in 1...gid {
        let file = "flashyset@\(id).txt"
        /*
         Dear Donnie{
         Please use this code block to get data from file, than assign it to a temporary constant of type FlashySet called "UnarchivedSet".
         } With regards ; Whitman.
         */
        
        // Appends the temporary constant "UnarchivedSet" to our big 'ol list.
        // flashySetArray.append[UnarchivedSet]
        
    }
}
*/
