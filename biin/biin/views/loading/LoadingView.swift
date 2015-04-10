//  LoadingView.swift
//  biin
//  Created by Esteban Padilla on 1/15/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class LoadingView:UIView {

    var loadingLbl:UILabel?
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.biinColor()
        
        var labelHeight:CGFloat = 40.0
        var ypos:CGFloat = (frame.height / 2) - (labelHeight / 2)
        loadingLbl = UILabel(frame: CGRect(x:0, y:ypos, width:(frame.width - 100), height:labelHeight))
        loadingLbl!.font = UIFont(name: "Lato-Light", size: 30)
        loadingLbl!.textColor = UIColor.whiteColor()
        loadingLbl!.textAlignment = NSTextAlignment.Center
        loadingLbl!.numberOfLines = 0
        loadingLbl!.text = "Loading..."
        self.addSubview(loadingLbl!)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showHardwareError() {
        
        loadingLbl!.alpha = 0
        
        var labelHeight:CGFloat = 80.0
        var ypos:CGFloat = (frame.height / 2) - (labelHeight / 2)
        var errorLbl = UILabel(frame: CGRect(x:25, y:ypos, width:(self.frame.width - 50), height:labelHeight))
        errorLbl.font = UIFont(name: "Lato-Light", size: 18)
        errorLbl.text = "Your device does not support Biin due to harware requirements, please close this app."
        errorLbl.textColor = UIColor.whiteColor()
        errorLbl.textAlignment = NSTextAlignment.Center
        errorLbl.numberOfLines = 3

        self.addSubview(errorLbl)

    }
}