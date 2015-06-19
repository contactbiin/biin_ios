//  LoadingView.swift
//  biin
//  Created by Esteban Padilla on 1/15/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoadingView:UIView {

    var loadingLbl:UILabel?
    var biinLogo:UIImageView?
//    override init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        biinLogo = UIImageView(frame: CGRectMake(0, 100, 320, 320))
        biinLogo!.image = UIImage(named: "biinLogoLS.png")
        self.addSubview(biinLogo!)
        

        var ypos:CGFloat = 320
        loadingLbl = UILabel(frame: CGRect(x:0, y:ypos, width:frame.width, height:30))
        loadingLbl!.font = UIFont(name: "Lato-Black", size: 25)
        loadingLbl!.textColor = UIColor.appTextColor()
        loadingLbl!.textAlignment = NSTextAlignment.Center
        loadingLbl!.numberOfLines = 0
        loadingLbl!.text = NSLocalizedString("Loading", comment: "the Loading title")
        self.addSubview(loadingLbl!)
  
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showHardwareError() {
        
        loadingLbl!.alpha = 0
        biinLogo!.alpha = 0
        
        var labelHeight:CGFloat = 80.0
        var ypos:CGFloat = (frame.height / 2) - (labelHeight / 2)
        var errorLbl = UILabel(frame: CGRect(x:25, y:ypos, width:(self.frame.width - 50), height:labelHeight))
        errorLbl.font = UIFont(name: "Lato-Light", size: 18)
        errorLbl.text = NSLocalizedString("HardwareError", comment: "HardwareError")
        errorLbl.textColor = UIColor.blackColor()
        errorLbl.textAlignment = NSTextAlignment.Center
        errorLbl.numberOfLines = 3

        self.addSubview(errorLbl)

    }
}