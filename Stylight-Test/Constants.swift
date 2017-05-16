//
//  Constants.swift
//  Stylight-Test
//
//  Created by Prateek Kansara on 15/05/17.
//  Copyright © 2017 prateek. All rights reserved.
//

import Foundation
import UIKit

let DEBUG = false

/// Constants for application
class constants: NSObject{
    
    
    let tableTextViewHeight : CGFloat = 40.0
    let tableViewCellHeight : CGFloat = 60.0
    let tableHeaderHeight : CGFloat = 20.0
    
    let navigationTitleFont = UIFont.init(name: StylightTestFonts().AvenirNextBold, size: 20.0)
    
    let brandListTitleFont = UIFont.init(name: StylightTestFonts().AvenirNextDemiBold, size: 14.0)
}

class StylightErrorMessages: NSObject {
    
    let NoInternet = "No internet available"
    let serviceFailed = "Something Went wrong, Please try again!"
    
}

let sectionTitles : NSMutableArray = ["1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]

let sectionIndexTitle : NSMutableArray = ["1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]

/// App based Colors
class StylightColors : NSObject{
    
    //    let navigationColor = UIColor.init(red: 10/255.0, green: 86/255.0, blue: 138/255.0, alpha: 1.0)
    let navigationColor = UIColor.init(red: 210/255.0, green: 220/255.0, blue: 227/255.0, alpha: 1.0)
    
    let listHeaderColor = UIColor.black
    
    let appBackgroundColors = [
        UIColor.init(red: 10/255.0, green: 86/255.0, blue: 138/255.0, alpha: 1.0).cgColor,
        UIColor.init(red: 0/255.0, green: 120/255.0, blue: 135/255.0, alpha: 1.0).cgColor,
        UIColor.init(red: 0/255.0, green: 125/255.0, blue: 125/255.0, alpha: 1.0).cgColor,
        UIColor.init(red: 0/255.0, green: 155/255.0, blue: 130/255.0, alpha: 1.0).cgColor
    ]
    
    let AppBkg = [
        UIColor.init(red: 200/255.0, green: 210/255.0, blue: 217/255.0, alpha: 1.0).cgColor,
        UIColor.init(red: 158/255.0, green: 167/255.0, blue: 174/255.0, alpha: 1.0).cgColor,
        UIColor.init(red: 140/255.0, green: 150/255.0, blue: 157/255.0, alpha: 1.0).cgColor,
        UIColor.init(red: 80/255.0, green: 89/255.0, blue: 96/255.0, alpha: 1.0).cgColor
    ]
    
    
}


// App Based font
class StylightTestFonts: NSObject {
    //---Avenir Next Condensed---
    let AvenirNextCondensedBoldItalic = "AvenirNextCondensed-BoldItalic"
    let AvenirNextCondensedHeavy = "AvenirNextCondensed-Heavy"
    let AvenirNextCondensedMedium = "AvenirNextCondensed-Medium"
    let AvenirNextCondensedRegular = "AvenirNextCondensed-Regular"
    let AvenirNextCondensedHeavyItalic = "AvenirNextCondensed-HeavyItalic"
    let AvenirNextCondensedMediumItalic = "AvenirNextCondensed-MediumItalic"
    let AvenirNextCondensedItalic = "AvenirNextCondensed-Italic"
    let AvenirNextCondensedUltraLightItalic = "AvenirNextCondensed-UltraLightItalic"
    let AvenirNextCondensedUltraLight = "AvenirNextCondensed-UltraLight"
    let AvenirNextCondensedDemiBold = "AvenirNextCondensed-DemiBold"
    let AvenirNextCondensedBold = "AvenirNextCondensed-Bold"
    let AvenirNextCondensedDemiBoldItalic = "AvenirNextCondensed-DemiBoldItalic"
    
    //---Avenir Next---
    let AvenirNextUltraLight = "AvenirNext-UltraLight"
    let AvenirNextUltraLightItalic = "AvenirNext-UltraLightItalic"
    let AvenirNextBold = "AvenirNext-Bold"
    let AvenirNextBoldItalic = "AvenirNext-BoldItalic"
    let AvenirNextDemiBold = "AvenirNext-DemiBold"
    let AvenirNextDemiBoldItalic = "AvenirNext-DemiBoldItalic"
    let AvenirNextMedium = "AvenirNext-Medium"
    let AvenirNextHeavyItalic = "AvenirNext-HeavyItalic"
    let AvenirNextHeavy = "AvenirNext-Heavy"
    let AvenirNextItalic = "AvenirNext-Italic"
    let AvenirNextRegular = "AvenirNext-Regular"
    let AvenirNextMediumItalic = "AvenirNext-MediumItalic"
    
    //---Avenir---
    let AvenirMedium = "Avenir-Medium"
    let AvenirHeavyOblique = "Avenir-HeavyOblique"
    let AvenirBook = "Avenir-Book"
    let AvenirLight = "Avenir-Light"
    let AvenirRoman = "Avenir-Roman"
    let AvenirBookOblique = "Avenir-BookOblique"
    let AvenirBlack = "Avenir-Black"
    let AvenirMediumOblique = "Avenir-MediumOblique"
    let AvenirBlackOblique = "Avenir-BlackOblique"
    let AvenirHeavy = "Avenir-Heavy"
    let AvenirLightOblique = "Avenir-LightOblique"
    let AvenirOblique = "Avenir-Oblique"
}
