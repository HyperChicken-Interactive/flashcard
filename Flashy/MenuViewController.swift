//
//  MenuViewController.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/22/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    // This is the ViewController for the menu view, which is the view you see upon start up
    ////////////////////////////////////////
    // And now, some wonderful IBOutlets: //
    ////////////////////////////////////////
    @IBOutlet weak var welcomeOutlet: UILabel!
    @IBOutlet weak var cardsetNameOutlet: UILabel!
    @IBOutlet weak var numberOfCardsOutlet: UILabel!
    @IBOutlet weak var flashOutlet: UIButton!
    @IBOutlet weak var editOutlet: UIButton!
    @IBOutlet weak var settingsOutlet: UIButton!
    @IBOutlet weak var cardsetPickerOutlet: UIPickerView!
    
    @IBAction func saved(_ sender: UIButton) {
        saveCards()
    }
    
    ///////////////////////////////////////////////////////
    // Fresh home-made functions and variables! By hand! //
    ///////////////////////////////////////////////////////
    func updateValuesInView() {
        // Any changes that need to be made to the text
        if let cardsetName = currentlySelectedFlashyCardset.name {
            cardsetNameOutlet.text = cardsetName
        } else {
            cardsetNameOutlet.text = "Select a cardset from the picker"
        }
        // Sets the cardset title to the name of the selected set, if that fails, it tells you to select a cardset.
        
        numberOfCardsOutlet.text = "\(currentlySelectedFlashyCardset.cardsInSet) cards"
        
        if currentlySelectedFlashyCardset.isSuper == true {
            flashOutlet.isHidden = true
            editOutlet.isHidden = true
        } else {
            flashOutlet.isHidden = false
            editOutlet.isHidden = false
        }
        
        if currentlySelectedFlashyCardset.cardsetArray.count == 0 {
            flashOutlet.isHidden = true
        } else {
            flashOutlet.isHidden = false
        }
        
        // Coloring the everything
        welcomeOutlet.textColor = currentlySelectedColorScheme.headerColor
        welcomeOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        cardsetNameOutlet.textColor = currentlySelectedColorScheme.highlightColor
        cardsetNameOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        numberOfCardsOutlet.textColor = currentlySelectedColorScheme.textColor
        numberOfCardsOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        flashOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        flashOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        editOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        editOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        settingsOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        settingsOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        view.backgroundColor = currentlySelectedColorScheme.backgroundColor
        cardsetPickerOutlet.tintColor = currentlySelectedColorScheme.textColor
        
        if let title = self.title {
            print("Updated values for \(title)")
        } else {
            print("Updated values for view with nil title (name it!)")
        } // Prints that is updated values for debugging.

        
    }
    
    // Now we deal with the picker
    
    let flashcardList = ["Select one", set01.shortName, set02.shortName, set03.shortName,set04.shortName, set05.shortName]
    // The data for the picker.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    } // The number of components in the picker, EG 3 for dates (Day, month, year)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return flashcardList.count
    } // The number of rows, which is the .count of our data, colorSelectData.
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return flashcardList[row]
    } // Gives names to the rows
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = flashcardList[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 15.0)!,NSForegroundColorAttributeName:currentlySelectedColorScheme.highlightColor])
        return myTitle
    } // Colors the text. Avenir won't work but fine.
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected cardset \"\(flashcardList[row])\"")
        switch flashcardList[row]{
        case flashcardList[0]: currentlySelectedFlashyCardset = flashySuper
        case flashcardList[1]: currentlySelectedFlashyCardset = set01
        case flashcardList[2]: currentlySelectedFlashyCardset = set02
        case flashcardList[3]: currentlySelectedFlashyCardset = set03
        case flashcardList[4]: currentlySelectedFlashyCardset = set04
        case flashcardList[5]: currentlySelectedFlashyCardset = set05
        default: print("ERROR, failed to select \(flashcardList[row])")
            // Changes the color scheme to whatever is selected.
        }
        updateValuesInView()
    } // Preforms an action when an items is selected.
    
    //////////////////////////
    // The viewDidLoad func //
    //////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cardsetPickerOutlet.dataSource = self
        cardsetPickerOutlet.delegate = self
        updateValuesInView()
    }
    
    /////////////////////////////////////////////////
    // Get your brand new IBAction functions here! //
    /////////////////////////////////////////////////
}
