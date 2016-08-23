//
//  EditorViewController.swift
//  Flashy
//
//  Created by Whitman Huntley on 8/23/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController{
    // The view controller for the flashy editor and customizer.
    
    ////////////////////////////////////////
    // And now, some wonderful IBOutlets: //
    ////////////////////////////////////////
    @IBOutlet weak var cardsetNameOutlet: UITextField!
    @IBOutlet weak var cardsetShortOutlet: UITextField!

    @IBOutlet weak var sideOneOutlet: UITextField!
    @IBOutlet weak var sideTwoOutlet: UITextField!
    
    @IBOutlet weak var cardNumberOutlet: UILabel!
    @IBOutlet weak var saveQuitOutlet: UIButton!
    @IBOutlet weak var quitOnlyOutlet: UIButton!
    @IBOutlet weak var previousOutlet: UIButton!
    @IBOutlet weak var nextOutlet: UIButton!
    ///////////////////////////////////////////////////////
    // Fresh home-made functions and variables! By hand! //
    ///////////////////////////////////////////////////////
    func updateValuesInView() {
        // Update text according to variables
        
        // Updating color scheme
        view.backgroundColor = currentlySelectedColorScheme.backgroundColor
    }
    
    //////////////////////////
    // The viewDidLoad func //
    //////////////////////////
    
    override func viewDidLoad() {
         // Do any additional setup after loading the view, typically from a nib.
        
        updateValuesInView()
    }
    
    /////////////////////////////////////////////////
    // Get your brand new IBAction functions here! //
    /////////////////////////////////////////////////
    @IBAction func saveQuitAction() {
    }
    
    @IBAction func quitOnlyAction() {
    }
    
    @IBAction func previousAction() {
    }
    
    @IBAction func nextAction() {
    }
    
    @IBAction func cardsetNameAction() {
        print("Editing did end")
    }
    
    
}

