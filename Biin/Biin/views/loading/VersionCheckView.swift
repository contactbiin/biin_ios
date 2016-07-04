//  VersionCheckView.swift
//  biin
//  Created by Esteban Padilla on 6/29/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class VersionCheckView:UIView {
    
    var loadingLbl:UILabel?
    var biinLogo:BNUIBiinView?
    var version:UILabel?
    
    var currentHighlight:Int = 0
    
    var biinLogoView:BiinLogoView?
    
    var loadingIndicator:BNActivityIndicator?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        let screenWidth = SharedUIManager.instance.screenWidth
        let screenHeight = SharedUIManager.instance.screenHeight
        var ypos:CGFloat = 0
        
        biinLogo = BNUIBiinView(position:CGPoint(x:0, y:ypos), scale:SharedUIManager.instance.signupView_logoSize)
        biinLogo!.frame.origin.x = ((screenWidth - biinLogo!.frame.width) / 2)
        biinLogo!.icon!.color = UIColor.blackColor()
        self.addSubview(biinLogo!)
        biinLogo!.setNeedsDisplay()
        
        ypos += (biinLogo!.frame.height + 5)
        
        version = UILabel(frame: CGRectMake(0, ypos, screenWidth, 15))
        version!.font = UIFont(name: "Lato-Light", size: 13)
        version!.textColor = UIColor.blackColor()
        version!.textAlignment = NSTextAlignment.Center
        let versionTxt = NSLocalizedString("Version", comment: "the version title")
        version!.text = "\( versionTxt ) \(BNAppSharedManager.instance.version)"
        self.addSubview(version!)
        
        ypos = ((screenHeight - ypos) / 2)
        biinLogo!.frame.origin.y = ypos
        ypos += biinLogo!.frame.height
        version!.frame.origin.y = ypos
        
        loadingLbl = UILabel(frame: CGRect(x:0, y:(screenHeight - 25), width:frame.width, height:18))
        loadingLbl!.font = UIFont(name: "Lato-Light", size: 15)
        loadingLbl!.textColor = UIColor.blackColor()
        loadingLbl!.textAlignment = NSTextAlignment.Center
        loadingLbl!.numberOfLines = 0
        loadingLbl!.text = NSLocalizedString("VersionChecking", comment: "VersionChecking")
        self.addSubview(loadingLbl!)
        
        loadingIndicator = BNActivityIndicator(frame:CGRectMake(((frame.width / 2) - 15), (screenHeight - 50), 20, 20))
        loadingIndicator!.rectShape!.strokeColor = UIColor.biinOrange().CGColor
        loadingIndicator!.rectShape!.fillColor = UIColor.clearColor().CGColor
        self.addSubview(loadingIndicator!)
        loadingIndicator!.start()
        
    }
    
    func toggle(sender: AnyObject!) {
        self.biinLogoView!.showsMenu = !self.biinLogoView!.showsMenu
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateProgressView(value:Float){ }
    
    func showHardwareError() {
        
        loadingLbl!.alpha = 0
        biinLogo!.alpha = 0
        
        let labelHeight:CGFloat = 80.0
        let ypos:CGFloat = (frame.height / 2) - (labelHeight / 2)
        let errorLbl = UILabel(frame: CGRect(x:25, y:ypos, width:(self.frame.width - 50), height:labelHeight))
        errorLbl.font = UIFont(name: "Lato-Light", size: 18)
        errorLbl.text = NSLocalizedString("HardwareError", comment: "HardwareError")
        errorLbl.textColor = UIColor.blackColor()
        errorLbl.textAlignment = NSTextAlignment.Center
        errorLbl.numberOfLines = 3
        
        self.addSubview(errorLbl)
        
    }
    
    func hideProgressView(){ }
}