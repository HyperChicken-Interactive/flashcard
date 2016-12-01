//
//  AlertModel.swift
//  Flashy
//
//  Created by Whitman Huntley on 29/11/16.
//  Copyright © 2016 HyperChicken Interactive. All rights reserved.
//

import UIKit

/**
 # A collection of debug functions
 
 The debugger class is a function of debugger functions and values to log data and whatnot. Each function is documented individually.
 */
struct Error {
    /**
     # Error codes
     
     Error codes for the app's logging. From least to most dangerous:
     
     - "warning": Something that should be known about (E.G. views did update, button was pressed)
     - "important": Something that should be noted, but is not dangerous for the time being (new cardset made, cards archived)
     - "critical": Dangerous code that, while caught, is still a bug that **needs** to be fixed ASAP. (NSKeyedArchiver turned up nothing)
     - "panic": These should never be seen and should be fixed immediatly. Any reports sent out with an error of panic **will be reported to the user** automatically.
     
     - ToDo: find a way to use this outside this struct.
     */
    enum ErrorCodes{
        case warning
        case important
        case critical
        case panic
    }
    /**
     # Gets the current time
     
    GetTime is a helper function that fetches the current time as to be shown in the logs when the error occured.
 
     - parameter OPadp : An option that tells into how many decimal places the time should be. If left nil, it will go to 5 decimal places. **Maximum of 7.**
     - returns: A formatted string.
     */
    private func getTime(AtDecimalPlace OPadp: Int?) -> String {
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
        
        if let adp = OPadp, adp >= 7 {
            for _ in 1...((nanoStr.characters.count)-adp) {
                nanoStr = nanoStr.substring(to: nanoStr.index(before: nanoStr.endIndex))
            }
        } else {
            for _ in 1...((nanoStr.characters.count)-5) {
                nanoStr = nanoStr.substring(to: nanoStr.index(before: nanoStr.endIndex))
            }
        }
        
        let nanoseconds = nanoStr
        
        return ("\(year)-\(month)-\(day)@\(hour):\(minutes):\(seconds).\(nanoseconds)")
    }
    
    /**
    # How data is actually logged
     
    This function logs data and handles actions via interactions with scope-private functions.
     
    - parameter err: The error code that denotes how important the log is.
    - parameter tm: To how many decimals should the time code be generated.
     */
    func log(Code err: ErrorCodes, AtTime tm: Int?, WithDescription desc: String, FromLocation loc: String?, AndOther o: [String]?) -> String{
        var returnedString: String = getTime(AtDecimalPlace: tm)
        
        if desc.hasSuffix(".") || desc.hasSuffix("!") || desc.hasSuffix("?") {
            returnedString += ": \(desc) "
        } else {
            returnedString += ": \(desc). "
        }
        
        if let file = loc {
            returnedString += "At location: \"\(file)\". "
        }
        
        returnedString += "\n"
        
        if let other = o {
            returnedString += "Also:\n"
            for time in other {
                returnedString += "  - \(time)\n"
            }
        }

        
        return returnedString
    }
    
}

extension UIViewController {
    func panic(About a: String) {
        let alert = UIAlertController(title: "CRITICAL", message: "You really shouldn't see this message. There was a critical error about \"\(a)\". Please contact head of development Whitman Huntley (whitman.colm@gmail.com) about this as soon as possible. The app will continue, but some features may not work correctly.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Understood", style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}




