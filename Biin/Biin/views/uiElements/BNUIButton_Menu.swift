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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //icon = BNIcon_ShareItButton(color: UIColor.biinColor(), position: CGPointMake(1, 1))
    }
    
    convenience init(frame:CGRect, text:String, iconType:BNIconType){
        self.init(frame:frame)
        
        self.iconType = iconType
        createIcon()
        
        label = UILabel(frame: CGRectMake(0, ((frame.height + 10) / 2), frame.width, 12))
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(3), range: NSRange(location: 0, length:(text.characters.count)))
        label!.attributedText = attributedString
        label!.textColor = UIColor.whiteColor()
        label!.font = UIFont(name: "Lato-Light", size: 12)
        label!.textAlignment = NSTextAlignment.Center
        self.addSubview(label!)
    }
    
    override func createIcon(){
        switch iconType {
        case .menuMedium:
            icon = BNIcon_Menu(color: UIColor.bnGrayLight(), position: CGPointMake(2, 4))
            break
        case .gift:
            icon = BNIcon_Gift(color: UIColor.bnGrayLight(), position: CGPointMake(2, 2))
            break
        case .notification:
            icon = BNIcon_Notification(color: UIColor.appButtonColor(), position: CGPointMake(37, 8))
            break
        case .profileMedium:
            icon = BNIcon_ProfileMedium(color: UIColor.appButtonColor(), position: CGPointMake(37, 7))
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
        case .informationMedium:
            icon = BNIcon_InformationMedium(color: UIColor.appButtonColor(), position: CGPointMake(37, 8))
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

