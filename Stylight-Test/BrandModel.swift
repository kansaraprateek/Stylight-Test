//
//  BrandModel.swift
//  Stylight-Test
//
//  Created by Prateek Kansara on 15/05/17.
//  Copyright © 2017 prateek. All rights reserved.
//

import Foundation
import WebService
import SVProgressHUD

@objc protocol BrandModelDelegate : NSObjectProtocol{
    func reloadBrandData(brandData : NSArray?)
}

class BrandModel : NSObject{
    
    var brandModelDelegateObject : BrandModelDelegate?
    
    let brandWebService = WebService()
    
    func fetchBrandData() {
        
        if UtilityMethods().isInternetAvailable(){
            
            brandWebService.sendRequest(StylightURL().brandGETURL, parameters: nil, requestType: .get, success: {
                response, responseData in
                
                if DEBUG{print(responseData)}
                
                if let responseDict = responseData as? NSDictionary{
                    if let brandData = responseDict.object(forKey: "brands") as? NSArray{
                            let brands = self.createBrandObjectArray(brandJSONObjs: brandData)
                        self.reloadCurrentView(brands: brands)
                    }
                }

            }, failed: {
                response, responseData in
                SVProgressHUD.showError(withStatus: StylightErrorMessages().serviceFailed)
            }, encoded: false)
        }
        else{
            SVProgressHUD.showError(withStatus: StylightErrorMessages().NoInternet)
        }
    }
    
    func createBrandObjectArray(brandJSONObjs : NSArray) -> NSArray {
        
        let brandObjectsArray = NSMutableArray()
        
        for object in brandJSONObjs{
            let brandObj = self.createBrandObject(brandDict: object as! NSDictionary)
            brandObjectsArray.add(brandObj)
        }
        return brandObjectsArray
    }
    
    func createBrandObject(brandDict : NSDictionary) -> Brand {
        
        let brandObject : Brand = Brand()
        
        brandDict.enumerateKeysAndObjects({
            key, value, _ in
            if brandObject.responds(to: NSSelectorFromString(key as! String)) {
                brandObject.setValue(value, forKey: key as! String)
            }
        })
        
        brandObject.id = brandDict.object(forKey: "id") as? Int
        
        return brandObject
    }
    
    
    
    func reloadCurrentView(brands : NSArray?) {
        if brandModelDelegateObject == nil {return}
        
        if (self.brandModelDelegateObject?.responds(to: #selector(BrandModelDelegate.reloadBrandData(brandData:))))!{
            self.brandModelDelegateObject?.reloadBrandData(brandData: brands)
        }
    }
    
}
