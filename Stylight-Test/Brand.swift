//
//  Brand.swift
//  Stylight-Test
//
//  Created by Prateek Kansara on 15/05/17.
//  Copyright © 2017 prateek. All rights reserved.
//

import Foundation
import UIKit

class Brand : NSObject {
    var id : Int!
    var name : String?
    var logo : String?
    var logoData : Data?
}

class brandCell: UITableViewCell {
 
    @IBOutlet var brandName : UILabel!
    @IBOutlet var brandImage : UIImageView!
    @IBOutlet var brandCheckBox : UIButton!
    
    @IBOutlet var bkgView : UIView!
    
    let cornerRadius = 5.0
    
    override func awakeFromNib() {
        self.initializeViews()
    }
    
    func initializeViews(){
        
        bkgView.backgroundColor = UIColor.clear
        bkgView.layer.borderWidth = 1.0
        bkgView.layer.borderColor = UIColor.black.cgColor
        
        UtilityMethods().addShadowToViews(view: bkgView, cornerRadius: CGFloat(cornerRadius))
    }
    
}
