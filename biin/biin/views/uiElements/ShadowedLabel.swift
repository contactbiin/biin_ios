//  ShadowedLabel.swift
//  Biin
//  Created by Esteban Padilla on 8/7/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit

class ShadowedLabel:UILabel {
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = false
    }
    
    override func drawTextInRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var shadowColor = UIColor(red:0, green: 0, blue: 0, alpha: 0.2).CGColor
        var shadowOffset = CGSizeMake(0.5, 0.5)
        CGContextSetShadowWithColor(context, shadowOffset, 1, shadowColor)
        super.drawTextInRect(rect)
        
        CGContextRestoreGState(context)
        
    }
    
}