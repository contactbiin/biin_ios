//  BNUIButton_WithLabel.swift
//  biin
//  Created by Esteban Padilla on 2/12/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import UIKit

class BNUIButton_WithLabel:BNUIButton {
    
    var label:UILabel?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(position: CGPoint, text:String, iconType:BNIconType, hasLabel:Bool) {
        
        self.init(frame:CGRectMake(position.x, position.y, 40, 40))
        
        self.iconType = iconType
        createIcon()
        
        self.layer.cornerRadius  = 3
        self.layer.masksToBounds = true
        
        if hasLabel {
            var iconWidth:CGFloat = 10
            var xSpace:CGFloat = 6
            var ypos:CGFloat = 1
            var xpos:CGFloat = xSpace + iconWidth
            
            label = UILabel(frame: CGRectMake(xpos, ypos, 200, 10))
            label!.text = text
            label!.textColor = UIColor.appMainColor()
            label!.font = UIFont(name: "Lato-Regular", size: 10)
            label!.sizeToFit()
            self.addSubview(label!)
            
            var width:CGFloat = label!.frame.width + xpos + xSpace
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, 15)
        }
    }
    
    override func createIcon(){
        switch iconType {
        case .notificationMedium:
            icon = BNIcon_NotificationMedium(color: UIColor.appIconColor(), position: CGPointMake(8, 8))
            break
        case .searchMedium:
            icon = BNIcon_SearchMedium(color: UIColor.appIconColor(), position: CGPointMake(9, 8))
            break
        default:
            break
        }
    }
}