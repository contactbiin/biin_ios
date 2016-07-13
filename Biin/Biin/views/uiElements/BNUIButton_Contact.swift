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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = BNIcon_ShareItButton(color: UIColor.biinColor(), position: CGPointMake(1, 1))
    }
    
    convenience init(frame:CGRect, text:String, iconType:BNIconType){
        self.init(frame:frame)
        
        //self.layer.cornerRadius = 20
        //self.layer.borderWidth = 3
        //self.layer.borderColor = UIColor.appButtonBorderColor().CGColor
        
        self.backgroundColor = UIColor.biinColor()
        
        self.iconType = iconType
        createIcon()
        
        label = UILabel(frame: CGRectMake(20, 0, frame.width, frame.height))
        label!.text = text
        label!.textColor = UIColor.appMainColor()
        label!.font = UIFont(name: "Lato-Black", size: 15)
        label!.textAlignment = NSTextAlignment.Center
        self.addSubview(label!)
    }
    
    override func createIcon(){
        switch iconType {
        case .phoneMedium:
            icon = BNIcon_PhoneMedium(color: UIColor.appMainColor(), position: CGPointMake(((frame.width / 2) - 40), 11))
            break
        case .emailMedium:
            icon = BNIcon_EmailMedium(color: UIColor.appMainColor(), position: CGPointMake(((frame.width / 2) - 50), 14))
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
        label!.textColor = UIColor.appMainColor()
        setNeedsDisplay()
    }
    
    override func showDisable() {
        icon!.color = UIColor.appButtonColor_Disable()
        label!.textColor = UIColor.appButtonColor_Disable()
        setNeedsDisplay()
    }
    
    func clean() {
        label?.removeFromSuperview()
    }
}

