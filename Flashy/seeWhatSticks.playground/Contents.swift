// A place where I can try out random theories.

import Foundation

let someArray = [0, 1, 2]
let itemsInSomeArray = someArray.count



// Just in case.

/*
if editSet.cardsInSet == 0 {
    nextOutlet.hidden = true
    previousOutlet.hidden = true
    doneOutlet.hidden = true
    // If we're on the first card that is to be genned for a new set, hide the next and previous buttons. The done button will be handled seperately.
} else if editSet.currentlySelectedFlashyCard == (editSet.cardsInSet) {
    nextOutlet.hidden = true
    previousOutlet.hidden = false
    doneOutlet.hidden = false
    // If the currently selected card index value is equal to the cards in set +1 (because .count starts with 1), then hide the next button and show the previous button.
} else if editSet.currentlySelectedFlashyCard == 0 {
    previousOutlet.hidden = true
    nextOutlet.hidden = false
    doneOutlet.hidden = false
    // If we are at index value 0, hide the previous button and show the next.
} else {
    nextOutlet.hidden = false
    previousOutlet.hidden = false
    doneOutlet.hidden = false
}

if editSet.cardsInSet < editSet.currentlySelectedFlashyCard || editSet.cardsInSet == 0 {
    // If the # of cards in set is greater than the currently selected card or if it is 0.
    if sideOneOutlet.text?.isEmpty == false && sideTwoOutlet.text?.isEmpty == false {
        print("WHY DOES IT ALWAYS FALLTHROUGH?!?")
        editSet.generateNewCard(sideOneOfCard: sideOneOutlet.text!, sideTwoOfCard: sideTwoOutlet.text!)
        sideTwoOutlet.placeholder = "Enter side one of the card!"
        sideTwoOutlet.placeholder = "Enter side two of the card!"
        nextOutlet.hidden = false
        previousOutlet.hidden = false
        if cardsetShortOutlet.text!.isEmpty == false {
            doneOutlet.hidden = false
        } else {
            doneOutlet.hidden = true
        }
        // If something is in the text fields, show all buttons and append the two text boxes to the edit set which will be written to the currently selected set.
    } else {
        sideTwoOutlet.placeholder = "You need something here"
        sideTwoOutlet.placeholder = "You need something here"
        nextOutlet.hidden = true
        previousOutlet.hidden = true
        doneOutlet.hidden = true
    }
} else if editSet.cardsInSet >= editSet.currentlySelectedFlashyCard {
    print("updateCardsetProperties: Second if chosen.")
    // If the selected "card" is within the range, preform the following. This is an if/else because generateNewFlashyCard
    if let text = sideOneOutlet.text {
        editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideOne = text
    } // Just an if let because sideOneOutlet.text is a string optional
    if let text = sideTwoOutlet.text {
        editSet.cardsetArray[editSet.currentlySelectedFlashyCard].sideTwo = text
    } // See above comment
    // If either of these are nil, nothing will happen and the previous side 1/2 will remain.
    
    print("Modified \(editSet.name), card \(editSet.currentlySelectedFlashyCard)")
}
editSet.name = cardsetNameOutlet.text
// Both optionals so who cares
//LOOK AT THIS SHIT.
if cardsetShortOutlet.text!.isEmpty == false {
    editSet.shortName = cardsetShortOutlet.text!
    doneOutlet.hidden = false
} else {
    doneOutlet.hidden = true
}

cardNumberOutlet.text = "Card #\(editSet.currentlySelectedFlashyCard+1)"
//Shows what card you are on.
*/
