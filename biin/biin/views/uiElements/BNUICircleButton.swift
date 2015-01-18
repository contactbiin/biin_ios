//  BNUICircleButton.swift
//  Biin
//  Created by Esteban Padilla on 8/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class BNUICircleButton:BNUIButton {
    
    
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
        
        self.layer.cornerRadius  = frame.width / 2
        self.layer.backgroundColor = color.colorWithAlphaComponent(alpha).CGColor

        if hasBorder {
            self.layer.borderColor = borderColor.CGColor
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
