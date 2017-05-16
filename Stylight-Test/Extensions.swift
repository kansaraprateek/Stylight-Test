//
//  Extensions.swift
//  Stylight-Test
//
//  Created by Prateek Kansara on 15/05/17.
//  Copyright © 2017 prateek. All rights reserved.
//

import Foundation
import UIKit

private let activityTag = 12011992
private let activitySize : CGFloat = 20
extension UIImageView {
    
    /**
     Extending UIImageView class to handle image downloading
     
     - parameter url:             image URL as String
     */
    
    func downloadedFrom(url: String, imageID : Int?, placeholderImage : UIImage?) {
        guard let url = URL(string: url) else { return }
        self.image = UIImage(data: Data())
        self.updateConstraintsIfNeeded()
        showAnimating()
        if UtilityMethods().isInternetAvailable(){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let image = UIImage(data: data!)
                    else {return}
                DispatchQueue.main.async(execute: {
                    self.endAnimating()
                    self.image = image
                    if imageID != nil {
                        
                        if data != nil{

                        }
                        else{
                            self.endAnimating()
                            if placeholderImage != nil{
                                self.image = placeholderImage
                            }
                        }
                    }
                })
                }.resume()
        }else{
            self.endAnimating()
            if placeholderImage != nil{
                self.image = placeholderImage
            }
        }
    }
    
    /**
     Custom method to show activity indicator within UIImageView when image is downloaded
     */
    private func showAnimating(){
        let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x:frame.width/2, y:frame.height/2, width:activitySize, height: activitySize)
//        activityIndicator.center = CGPoint.init(x: frame.width/2, y:frame.width/2)
        activityIndicator.tag = activityTag
        activityIndicator.color = UIColor.lightGray
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
    }
    
    /**
     Custom method to called when image is fully downlaoded.
     */
    private func endAnimating(){
        
        if let activityView = self.viewWithTag(activityTag) as? UIActivityIndicatorView{
            activityView.stopAnimating()
            activityView.removeFromSuperview()
        }
    }
    
    /// Setting blur effect to current image view
    func setImageViewBlur(){
        self.layoutIfNeeded()
        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = self.bounds
        self.addSubview(effectView)
    }
    
    
    /// Creating circular frame for imageview
    func createCircularFrame() {
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.size.height/2;
        self.clipsToBounds = true
    }
}

extension UINavigationController{
    
    /// Setting navigation background color
    ///
    /// - Parameter color: UIColor to be set on navigation bar
    func setNavBackgrounColor(_ color : UIColor)  {
        navigationBar.barTintColor = color
        navigationBar.isTranslucent = false
    }
}

extension UIButton {
    
    func setImage(image : UIImage, animated : Bool) {
        self.setImage(image, for: .normal)
        if animated{
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 2.0,
                           delay: 0,
                           usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 6.0,
                           options: .allowUserInteraction,
                           animations: { [weak self] in
                            self?.transform = .identity
                },
                           completion: nil)
        }
    }
    
}
