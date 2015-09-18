//  BNIcon_FriendsMedium.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_FriendsMedium:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
 
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(2, 0, 7.6, 7.6))
        color!.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(6.08, 10.17))
        bezier2Path.addCurveToPoint(CGPointMake(0, 20.56), controlPoint1: CGPointMake(2.71, 10.17), controlPoint2: CGPointMake(0, 14.47))
        bezier2Path.addLineToPoint(CGPointMake(3.96, 20.56))
        bezier2Path.addLineToPoint(CGPointMake(3.96, 25.9))
        bezier2Path.addLineToPoint(CGPointMake(8.35, 25.9))
        bezier2Path.addLineToPoint(CGPointMake(8.35, 20.56))
        bezier2Path.addLineToPoint(CGPointMake(12.31, 20.56))
        bezier2Path.addCurveToPoint(CGPointMake(6.08, 10.17), controlPoint1: CGPointMake(12.31, 14.47), controlPoint2: CGPointMake(9.45, 10.17))
        bezier2Path.closePath()
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalInRect: CGRectMake(17.6, 0, 7.8, 7.8))
        color!.setStroke()
        oval4Path.lineWidth = 2
        oval4Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(27.4, 9.8))
        bezier4Path.addLineToPoint(CGPointMake(15.09, 9.8))
        bezier4Path.addCurveToPoint(CGPointMake(19.05, 18.55), controlPoint1: CGPointMake(15.09, 14.69), controlPoint2: CGPointMake(16.92, 17.37))
        bezier4Path.addLineToPoint(CGPointMake(19.05, 25.9))
        bezier4Path.addLineToPoint(CGPointMake(23.44, 25.9))
        bezier4Path.addLineToPoint(CGPointMake(23.44, 18.55))
        bezier4Path.addCurveToPoint(CGPointMake(27.4, 9.8), controlPoint1: CGPointMake(25.71, 17.37), controlPoint2: CGPointMake(27.4, 14.69))
        bezier4Path.closePath()
        color!.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}