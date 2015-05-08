//  BNUIButton_Menu.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUIButton_Menu:BNUIButton {
    
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
        
        self.iconType = iconType
        createIcon()
        
        label = UILabel(frame: CGRectMake(0, ((frame.height + 10) / 2), frame.width, 15))
        label!.text = text
        label!.textColor = UIColor.appTextColor()
        label!.font = UIFont(name: "Lato-Light", size: 13)
        label!.textAlignment = NSTextAlignment.Center
        self.addSubview(label!)
    }
    
    override func createIcon(){
        switch iconType {
        case .profileMedium:
            icon = BNIcon_ProfileMedium(color: UIColor.appButtonColor(), position: CGPointMake(37, 7))
            break
        case .homeMedium:
            icon = BNIcon_HomeMedium(color: UIColor.appButtonColor(), position: CGPointMake(35, 7))
            break
        case .collectionMedium:
            icon = BNIcon_CollectionsMedium(color: UIColor.appButtonColor(), position: CGPointMake(35, 6))
            break
        case .loyaltyMedium:
            icon = BNIcon_LoyaltiesMedium(color: UIColor.appButtonColor(), position: CGPointMake(37, 7))
            break
        case .notificationMedium:
            icon = BNIcon_NotificationMedium(color: UIColor.appButtonColor(), position: CGPointMake(37, 8))
            break
        case .menuMedium:
            icon = BNIcon_MenuMedium(color: UIColor.blackColor(), position: CGPointMake(2, 2))
            break
        case .friendsMedium:
            icon = BNIcon_FriendsMedium(color: UIColor.appButtonColor(), position: CGPointMake(35, 7))
            break
        case .settingsMedium:
            icon = BNIcon_SettingsMedium(color: UIColor.appButtonColor(), position: CGPointMake(36, 7))
            break
        case .searchMedium:
            icon = BNIcon_SearchMedium(color: UIColor.appButtonColor(), position: CGPointMake(35, 8))
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
        self.icon!.color = UIColor.appButtonColor()
        setNeedsDisplay()
    }
    
    override func showDisable() {
        icon!.color = UIColor.appButtonColor_Disable()
        label!.textColor = UIColor.appButtonColor_Disable()
    }
}

