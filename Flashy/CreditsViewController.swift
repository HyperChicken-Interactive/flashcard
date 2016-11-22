//
//  CreditsViewController.swift
//  Flashy
//
//  Created by Whitman Huntley on 22/11/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    func updateValuesInView() {
        logdata(infoText: "Updated values in view", fileOccured: "CreditsViewController.swift", objectRunIn: nil, otherInfo: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateValuesInView()
        loginfo(infoText: "View loaded successfully", fileOccured: "FlashViewController.swift", objectRunIn: title, otherInfo: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        loginfo(infoText: "CRITICAL: A memory warning was recived", fileOccured: "CreditsViewController.swift", objectRunIn: nil, otherInfo: nil)
    }
    
}
