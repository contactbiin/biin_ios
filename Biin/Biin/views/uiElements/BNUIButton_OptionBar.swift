//  BNUIButton_OptionBar.swift
//  Biin
//  Created by Esteban Padilla on 7/13/16.
//  Copyright © 2016 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_OptionBar:BNUIButton {
    
    var label:UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect, text:String, iconType:BNIconType){
        self.init(frame:frame)
        
        self.iconType = iconType
        createIcon()
        
        label = UILabel(frame: CGRectMake((-10), (frame.height - 2), (frame.width + 20), 10))
        label!.text = text
        label!.textColor = UIColor.bnOptionBarIconColor()
        label!.font = UIFont(name: "Lato-Black", size: 8)
        label!.textAlignment = NSTextAlignment.Center
        self.addSubview(label!)
    }
    
    override func createIcon(){
        switch iconType {
        case .menuMedium:
            icon = BNIcon_Menu(color: UIColor.bnOptionBarIconColor(), position: CGPointMake(6, 9))
            break
        case .gift:
            icon = BNIcon_Gift(color: UIColor.bnOptionBarIconColor(), position: CGPointMake(5, 1))
            break
        case .notification:
            icon = BNIcon_Notification(color: UIColor.bnOptionBarIconColor(), position: CGPointMake(4, 5))
            break
        case .loyaltyWallet:
            icon = BNIcon_LoyaltyWallet(color: UIColor.bnOptionBarIconColor(), position: CGPointMake(1, 3))
            break
        case .none:
            break
        default:
            break
        }
    }
    
    override func showSelected() {
        //self.icon!.color = UIColor.biinColor()
        setNeedsDisplay()
    }
    
    override func showEnable() {
        //self.icon!.color = UIColor.appButtonColor()
        label!.textColor = UIColor.whiteColor()
        self.enabled = true
        setNeedsDisplay()
    }
    
    override func showDisable() {
        //icon!.color = UIColor.appButtonColor_Disable()
        label!.textColor = UIColor.blackColor()
        self.enabled = false
    }
}
