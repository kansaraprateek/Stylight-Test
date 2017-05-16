//
//  UtilityMethods.swift
//  Stylight-Test
//
//  Created by Prateek Kansara on 15/05/17.
//  Copyright © 2017 prateek. All rights reserved.
//

import Foundation
import ReachabilitySwift

class UtilityMethods: NSObject {
    
    
    //MARK:- Internet Reachability
    func isInternetAvailable() -> Bool {
        
        let reachability = Reachability.init()!
        
        return reachability.isReachable
    }
    func appBackground() -> CAGradientLayer{
        
        let gradient = CAGradientLayer()
        
        gradient.frame = UIScreen.main.bounds
        gradient.colors = StylightColors().AppBkg
        
        return gradient
    }
    
    /// Adding shadows to current views
    ///
    /// - Parameters:
    ///   - view: UIView object for adding shadow effect to
    ///   - cornerRadius: corner radius to be set for uiview
    func addShadowToViews(view: UIView, cornerRadius: CGFloat){
        
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowRadius = cornerRadius
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.3
        
        
    }
    
    /**
     Method to index list within the app
     To sort data from A-Z)
     
     - returns: Returns a dictionary with all the data indexed.
     */
    
    func createIndexedDictionary (data : [Brand]) -> NSMutableDictionary{
        
        let mutableData : NSMutableDictionary = NSMutableDictionary()
        
        sectionIndexTitle.enumerateObjects({
            (object : Any, index : Int, _) in
            let selectedData = data.filter {
                (brandObject : Brand) -> Bool in
                if (brandObject.name?.hasPrefix(object as! String))!{
                    return true
                }
                return false
            }
            
            if selectedData.count > 0{
                mutableData.setObject(selectedData, forKey: object as! NSCopying)
            }
        })
        
        return mutableData
    }
}
