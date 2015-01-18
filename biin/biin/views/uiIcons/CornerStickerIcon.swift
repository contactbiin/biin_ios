//  CornerStickerIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/10/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class CornerStickerIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.scale = scale
        super.position = position
        super.stroke = stroke
        super.isFilled = isFilled
    }
    
    override func drawCanvas() {
        //// Color Declarations
        let colorLines = UIColor.whiteColor()
        
        //// Group
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(0, 63.5))
        bezier2Path.addLineToPoint(CGPointMake(43.1, 63.5))
        bezier2Path.addLineToPoint(CGPointMake(63.5, 43.1))
        bezier2Path.addLineToPoint(CGPointMake(63.5, 0))
        bezier2Path.addLineToPoint(CGPointMake(0, 63.5))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(63.5, 2.7))
        bezier4Path.addLineToPoint(CGPointMake(63.5, 1.6))
        bezier4Path.addLineToPoint(CGPointMake(1.7, 63.5))
        bezier4Path.addLineToPoint(CGPointMake(2.7, 63.5))
        bezier4Path.addLineToPoint(CGPointMake(63.5, 2.7))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        colorLines.setFill()
        bezier4Path.fill()
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(63.5, 42.2))
        bezier6Path.addLineToPoint(CGPointMake(63.5, 41.1))
        bezier6Path.addLineToPoint(CGPointMake(41.2, 63.5))
        bezier6Path.addLineToPoint(CGPointMake(42.2, 63.5))
        bezier6Path.addLineToPoint(CGPointMake(63.5, 42.2))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        colorLines.setFill()
        bezier6Path.fill()
        
    }
}
