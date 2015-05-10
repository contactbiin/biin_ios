//  BNUIButton_Contact.swift
//  biin
//  Created by Esteban Padilla on 2/28/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_Contact:BNUIButton {
    
    var label:UILabel?
    
//    override init() {
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_ShareItButton(color: UIColor.biinColor(), position: CGPointMake(1, 1))
    }
    
    convenience init(frame:CGRect, text:String, iconType:BNIconType){
        self.init(frame:frame)
        
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        
        self.iconType = iconType
        createIcon()
        
        label = UILabel(frame: CGRectMake(0, (frame.height), frame.width, 15))
        label!.text = text
        label!.textColor = UIColor.appTextColor()
        label!.font = UIFont(name: "Lato-Light", size: 13)
        label!.textAlignment = NSTextAlignment.Center
        self.addSubview(label!)
    }
    
    override func createIcon(){
        switch iconType {
        case .phoneMedium:
            icon = BNIcon_PhoneMedium(color: UIColor.biinColor(), position: CGPointMake(23, 11))
            break
        case .emailMedium:
            icon = BNIcon_EmailMedium(color: UIColor.biinColor(), position: CGPointMake(22.5, 14))
            break
        case .commentMedium:
            icon = BNIcon_CommentMedium(color: UIColor.biinColor(), position: CGPointMake(12, 12))
            break
        default:
            break
        }
    }
    
    override func showSelected() {
        self.icon!.color = UIColor.biinColor()
        setNeedsDisplay()
    }
    
    override func showEnable() {
        //self.icon!.color = UIColor.appButtonColor()
        label!.textColor = UIColor.appTextColor()
        setNeedsDisplay()
    }
    
    override func showDisable() {
        icon!.color = UIColor.appButtonColor_Disable()
        label!.textColor = UIColor.appButtonColor_Disable()
        setNeedsDisplay()
    }
}

