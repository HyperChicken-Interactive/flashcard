//
//  PreferenceViewController.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/22/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    // This is the ViewController for the menu view, which is the view you see upon start up
    
    ////////////////////////////////////////
    // And now, some wonderful IBOutlets: //
    ////////////////////////////////////////
    @IBOutlet weak var HeaderOutlet: UILabel!
    @IBOutlet weak var TextOutlet: UILabel!
    @IBOutlet weak var ButtonOutlet: UIButton!
    @IBOutlet weak var FlashcardOutlet: UILabel!
    @IBOutlet weak var AutosaveLabelOutlet: UILabel!
    
    
    @IBOutlet weak var AutosaveSwitchView: UISwitch!
    @IBOutlet weak var ColorSelectView: UIPickerView!
    @IBOutlet weak var BackButtonOutlet: UIButton!
    ///////////////////////////////////////////////////////
    // Fresh home-made functions and variables! By hand! //
    ///////////////////////////////////////////////////////
    let colorSelectData = ["Select one", "Carbon", "Showroom", "Solarized Dark", "Solarized Light"]
    // The data for the picker.
    
    // Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    } // The number of components in the picker, EG 3 for dates (Day, month, year)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorSelectData.count
    } // The number of rows, which is the .count of our data, colorSelectData.
    
    // Functions for the picker, I hate saying this but right now, it just sorta works. Don't touch please and thanks.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorSelectData[row]
    } // Gives names to the rows
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Changed color scheme to \(colorSelectData[row])")
        swapColorScheme(to: colorSelectData[row])
            // Changes the color scheme to whatever is selected.
        updateValuesInView()
    } // Preforms an action when an items is selected.
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = colorSelectData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 15.0)!,NSForegroundColorAttributeName:currentlySelectedColorScheme.highlightColor])
        return myTitle
    } // Colors the text. Avenir won't work but fine.
    
    func updateValuesInView(){
        HeaderOutlet.textColor = currentlySelectedColorScheme.highlightColor
        HeaderOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        TextOutlet.textColor = currentlySelectedColorScheme.textColor
        TextOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        ButtonOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        ButtonOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        FlashcardOutlet.textColor = currentlySelectedColorScheme.textColor
        FlashcardOutlet.backgroundColor = currentlySelectedColorScheme.flashcardColor
        
        BackButtonOutlet.tintColor = currentlySelectedColorScheme.highlightColor
        BackButtonOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        AutosaveLabelOutlet.tintColor = currentlySelectedColorScheme.textColor
        AutosaveLabelOutlet.backgroundColor = currentlySelectedColorScheme.boxColor
        
        view.backgroundColor = currentlySelectedColorScheme.backgroundColor
        
        if AutosaveSwitchView.isOn == true {
            cardEditsWillAutoSave = true
            archiveUserDefaults(CurentlySelectedColorScheme: nil, AutoSaveFlashcards: cardEditsWillAutoSave)
        } else {
            cardEditsWillAutoSave = false
            archiveUserDefaults(CurentlySelectedColorScheme: nil, AutoSaveFlashcards: cardEditsWillAutoSave)
        }
        
        
        
        logdata(infoText: "Updated values for view.", fileOccured: "PreferenceViewController.swift", objectRunIn: title, otherInfo: nil)
        
    } // Updates all of the colors in the view. Pretty damn swanky if I do say so myself.
    
    //////////////////////////
    // The viewDidLoad func //
    //////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        // The only reason the viewDidLoad func doesn't contain all the code needed to format the text boxes and whatnot is becasue we need the color scheme to update so the user can see what the different varients look like.
        
        // This bit is weird, it's both a get and a set so I can swap sides to write to cardEditsWillAutoSave. As can be seen in the updateValuesInView().
        AutosaveSwitchView.isOn = cardEditsWillAutoSave
        AutosaveLabelOutlet.text = "Enable automatic saving when editing cardests?"
        
        ColorSelectView.dataSource = self
        ColorSelectView.delegate = self
        updateValuesInView()
        loginfo(infoText: "View loaded successfully", fileOccured: "PreferenceViewController.swift", objectRunIn: title, otherInfo: nil)
    }
    
    /////////////////////////////////////////////////
    // Get your brand new IBAction functions here! //
    /////////////////////////////////////////////////
    
    @IBAction func switchValueHasChanged() {
        updateValuesInView()
    }
    
    
    
}
