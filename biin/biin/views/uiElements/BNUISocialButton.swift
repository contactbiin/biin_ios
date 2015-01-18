//  BNUISocialButton.swift
//  Biin
//  Created by Esteban Padilla on 10/3/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUISocialButton:BNUIButton {
    
    var borderColor:UIColor?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color:UIColor, iconColor:UIColor, iconStroke:CGFloat, iconType:BNUIIConType, iconAlignment:BNUIIconAlignment, isIconFilled:Bool, fontSize:CGFloat, hasLabel:Bool, alpha:CGFloat, hasBorder:Bool, borderWidth:CGFloat, borderColor:UIColor, hasShadow:Bool) {
        
        self.init(frame:frame, color:color, iconColor:iconColor, iconStroke:iconStroke, iconType:iconType, iconAlignment:iconAlignment, isIconFilled:isIconFilled, fontSize:fontSize, hasLabel:hasLabel)
        
        self.layer.cornerRadius  = 3
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        
        self.borderColor = borderColor
        
        if hasBorder {
            self.layer.borderColor = self.borderColor!.CGColor
            self.layer.borderWidth = borderWidth
            
            if hasShadow {
                self.layer.shadowColor = UIColor.blackColor().CGColor
                self.layer.shadowOffset = CGSizeMake(0, 0)
                self.layer.shadowOpacity = 0.6
                self.layer.shadowRadius = 2
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        if iconType != BNUIIConType.None {
            icon?.drawCanvas()
        }
    }
}
