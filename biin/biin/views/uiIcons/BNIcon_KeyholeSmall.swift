//  BNIcon_KeyholeSmall.swift
//  biin
//  Created by Esteban Padilla on 2/11/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_KeyholeSmall:BNIcon {
    
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
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 28, 28))
        color!.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(18.34, 10.14))
        bezier2Path.addCurveToPoint(CGPointMake(14, 5.79), controlPoint1: CGPointMake(18.34, 7.77), controlPoint2: CGPointMake(16.37, 5.79))
        bezier2Path.addCurveToPoint(CGPointMake(9.66, 10.14), controlPoint1: CGPointMake(11.63, 5.79), controlPoint2: CGPointMake(9.66, 7.77))
        bezier2Path.addCurveToPoint(CGPointMake(12.07, 14), controlPoint1: CGPointMake(9.66, 11.83), controlPoint2: CGPointMake(10.67, 13.32))
        bezier2Path.addLineToPoint(CGPointMake(10.14, 23.17))
        bezier2Path.addLineToPoint(CGPointMake(18.34, 23.17))
        bezier2Path.addLineToPoint(CGPointMake(15.93, 14))
        bezier2Path.addCurveToPoint(CGPointMake(18.34, 10.14), controlPoint1: CGPointMake(17.33, 13.32), controlPoint2: CGPointMake(18.34, 11.83))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
