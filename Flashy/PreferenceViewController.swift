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
    
    @IBOutlet weak var ColorSelectView: UIPickerView!
    @IBOutlet weak var BackButtonOutlet: UIButton!
    ///////////////////////////////////////////////////////
    // Fresh home-made functions and variables! By hand! //
    ///////////////////////////////////////////////////////
    let colorSelectData = ["Solarized Dark", "Solarized Light"]
    // The data for the picker.
    
    // Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    } // The number of components in the picker, EG 3 for dates (Day, month, year)
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorSelectData.count
    } // The number of rows, which is the .count of our data, colorSelectData.
    
    // Functions for the picker, I hate saying this but right now, it just sorta works. Don't touch please and thanks.
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorSelectData[row]
    } // Gives names to the rows
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        HeaderOutlet.text = colorSelectData[row]
    } // Preforms an action when an items is selected.
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = colorSelectData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 15.0)!,NSForegroundColorAttributeName:UIColor.blueColor()])
        return myTitle
    }
    
    
    
    //////////////////////////
    // The viewDidLoad func //
    //////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ColorSelectView.dataSource = self
        ColorSelectView.delegate = self
    }
    
    /////////////////////////////////////////////////
    // Get your brand new IBAction functions here! //
    /////////////////////////////////////////////////
    @IBAction func ButtonPress() {
        
    }
    
    
}