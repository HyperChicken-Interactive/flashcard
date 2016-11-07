import Foundation

func loginfo(infoText: String?, fileOccured: String?, objectRunIn: String?, otherInfo: [String]?){  }
func logdata(infoText: String?, fileOccured: String?, objectRunIn: String?, otherInfo: [String]?){  }

var idMarker = 0

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
     
     Don't worry, the optional is handeled properly.
     */
    var name: String?
    
    /// Short name to be used on the picker.
    var shortName: String = "Blank"
    
    /** I can't think of a better name for this.
     This is a value to indicate wether the set this vale is a member of is either the edit set or the superset.
     
     Usage: This instance is used in the menu to see if the selected set is the default superset. When the default set is selected and an attempt to move to the preference view is made, a new cardset is appended to
     */
    let isIgnored: Bool
    
    /// A unique identifying integer, used primarily in saving the files.
    let uniqueID: Int?
    
    /// The variable name explains this quite well.
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
    
    init(isInitializedViaEncoder ive: Bool, nameOfFlashcardSet n: String?, shortNameOfSet s: String?, isIgnored su: Bool, cardsInSet csa: [FlashyCard]?, uniqueIdentifier uid: Int?){
        if let name = n {
            self.name = name
            loginfo(infoText: "NAME property initialized", fileOccured: nil, objectRunIn: "FlashySet.init()", otherInfo: ["Given property: \(name)"])
        } else {
            loginfo(infoText: "NAME property failed to initialize", fileOccured: nil, objectRunIn: "FlashySet.init()", otherInfo: nil)
        }
        if let sn = s {
            self.shortName = sn
            loginfo(infoText: "ShortName property initialized", fileOccured: nil, objectRunIn: "FlashySet.init()", otherInfo: ["Given property: \(shortName)"])
        } else {
            loginfo(infoText: "CRITICAL: ShortName property failed to initialize", fileOccured: nil, objectRunIn: "FlashySet.init()", otherInfo: ["For safty precautions, the shortname has been changed to an empty string."])
            self.shortName = ""
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
            self.cardsContained = cardsetArray
            self.uniqueID = uid!
        }
    }
    
    func generateNewCard(sideOneOfCard s1: String, sideTwoOfCard s2: String) {
        self.cardsetArray.append(FlashyCard(sideOne: s1, sideTwo: s2))
        // Will take in card strings provided by user and cast them into FlashyCards.
    }
    
    /// Forces equivilency between "tbr", which is the set to be cloned, and self. Used when "saving" edit set.
    func forceEquivilency(setToBeRead tbr: FlashySet, fileRunFrom frf: String?) {
        loginfo(infoText: "Attempting to force equivilency between \(tbr.shortName) and \(self.shortName)", fileOccured: frf, objectRunIn: "forceEquivilency", otherInfo: nil)
        self.name = tbr.name
        self.shortName = tbr.shortName
        self.cardsetArray = tbr.cardsetArray
        self.cardsContained = tbr.cardsContained
        loginfo(infoText: "Forced equivilency succeded.", fileOccured: frf, objectRunIn: "forceEquivilency", otherInfo: nil)
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
    
    // Below is code directly copied and pasted from NSHipter with some name changes in terms of variables. I have no shame.
    
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
    for card in ([flashySuper] + flashySetArray){
        returnedArray.append(card.shortName)
    }
    return returnedArray
}

// Creating child classes for the actual sets.

var flashySuper: FlashySet = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: "Click edit to create a new set", shortNameOfSet: "New set", isIgnored: true, cardsInSet: [], uniqueIdentifier: nil)

var editSet: FlashySet = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: nil, shortNameOfSet: nil, isIgnored: true, cardsInSet: nil, uniqueIdentifier: nil)

/**
 ## The array of ALL custom-made flashysets.
 
 This is the array of all **custom-made** cardsets. Meaning the editset and original cardset are not included. This cardset will be what is stored when the app closes.
 */
var flashySetArray: [FlashySet] = []

func saveFlashySets(_ tba: [FlashySet]){
    if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
        
        // Append your file name to the directory path
        let path = (docs as NSString).appendingPathComponent("flashysets.plist")
        
        // Archive your object to a file at that path
        NSKeyedArchiver.archiveRootObject(tba, toFile: path)
        
    } else {
        logdata(infoText: "CRITICAL: Failed to archive data for Set", fileOccured: nil, objectRunIn: "saveFlashySets(...)", otherInfo: nil)
    }
}

/**
 # Unarchive Cardsets from flashycards.plist
 
 This function unarchives a flashyset from the file flashysets.plist.
 
 - parameter fls: The flashyset to be written to from archive. This should probably be flashySetArray
 */
func unarchiveFlashySets(_ fls: inout [FlashySet]) {
    
    if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
        
        // Append your file name to the directory path
        let path = (docs as NSString).appendingPathComponent("flashysets.plist")
        
        // Unarchive your object from the file
        if let result = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [FlashySet] {
            loginfo(infoText: "Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["File was found. Restoring from archive."])
            fls = result
        } else {
            print ("Bloody hell! We're going to need more power to turn this around!")
            loginfo(infoText: "CRITICAL: Unarchived data for FlashySet array", fileOccured: nil, objectRunIn: nil, otherInfo: ["There was no archive availible. Creating empty array."])
            fls = []
        }
    }
}

// Code goes here now:

var set01 = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: "Hello", shortNameOfSet: "World", isIgnored: false, cardsInSet: nil, uniqueIdentifier: nil)
var set02 = FlashySet(isInitializedViaEncoder: false, nameOfFlashcardSet: "Goodbye", shortNameOfSet: "Or something", isIgnored: false, cardsInSet: nil, uniqueIdentifier: nil)
flashySetArray = [set01, set02]

saveFlashySets(flashySetArray)

flashySetArray = []

unarchiveFlashySets(&flashySetArray)

flashySetArray.count


// Now using a modified method from book:

flashySetArray = [set01, set02]

if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
    
    // Append your file name to the directory path
    let path = (docs as NSString).appendingPathComponent("flashysets.plist")
    
    // Archive your object to a file at that path
    NSKeyedArchiver.archiveRootObject(flashySetArray, toFile: path)
}

flashySetArray = []

if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
    
    // Append your file name to the directory path
    let path = (docs as NSString).appendingPathComponent("flashysets.plist")
    
    // Unarchive your object from the file
    if let result = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [FlashySet] {
        print("Yeahhh, now it's reyn time!")
        print(result.count)
    } else {
        print ("Bloody hell! We're going to need more power to turn this around!")
    }
    
    // do whatever with yourObject
}

flashySetArray.count



