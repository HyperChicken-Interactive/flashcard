import Foundation

class FlashyCard: NSObject, NSCoding {
    var sideOne: String
    var sideTwo: String
    var currentlySelectedSide: String
    func flipCard() {
        switch currentlySelectedSide {
        case sideOne:
            currentlySelectedSide = sideTwo
        case sideTwo:
            currentlySelectedSide = sideOne
        default:
            print("CRITICAL FAILURE. LINE 14")
        }
    }
    init(isInitializedViaEncoder ive: Bool, sideOne: String, sideTwo: String, currentlySelectedSide css: Int?) {
        self.sideOne = sideOne
        self.sideTwo = sideTwo
        if ive == false {
            self.currentlySelectedSide = sideOne
        } else {
            if css! == 1 {
                self.currentlySelectedSide = sideOne
            } else {
                self.currentlySelectedSide = sideTwo
            }
        }
    }
    
    /////
    
    required convenience init?(coder decoder: NSCoder) {
        guard let sideOne = decoder.decodeObject(forKey: "sideOne") as? String,
            let sideTwo = decoder.decodeObject(forKey: "sideTwo") as? String,
            let selectedSide = decoder.decodeObject(forKey: "selectedSide") as? Int,
            else { return nil }
        
        self.init(
            isInitializedViaEncoder: true,
            sideOne: sideOne,
            sideTwo: sideTwo,
            currentlySelectedSide: selectedSide
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.sideOne, forKey: "sideOne")
        coder.encode(self.sideTwo, forKey: "sideTwo")
        coder.encode(self.currentlySelectedSide, forKey: "selectedSide")
    }
}

var someCard = FlashyCard(isInitializedViaEncoder: false, sideOne: "Hello", sideTwo: "World", currentlySelectedSide: nil)

var anotherCard = FlashyCard(isInitializedViaEncoder: false, sideOne: "Goodbye", sideTwo: "Cruel world", currentlySelectedSide: nil)

var cardset: [FlashyCard] = [someCard, anotherCard]

// Get documents directory
if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
    
    // Append your file name to the directory path
    let path = (docs as NSString).appendingPathComponent("flashysets.plist")
    
    // Archive your object to a file at that path
    NSKeyedArchiver.archiveRootObject(cardset, toFile: path)
}

cardset = [someCard]

someCard.sideOne = "Foo"
someCard.sideOne = "Bar"

anotherCard.sideOne = "Bax"
anotherCard.sideTwo = "Quz"

// Get documents directory
if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
    
    // Append your file name to the directory path
    let path = (docs as NSString).appendingPathComponent("flashysets.plist")
    
    // Unarchive your object from the file
    if let result = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [FlashyCard] {
        print("Yeahhh, now it's reyn time!")
        print(result[0].currentlySelectedSide)
    } else {
        print ("Bloody hell! We're going to need more power to turn this around!")
    }
    
    // do whatever with yourObject
}
