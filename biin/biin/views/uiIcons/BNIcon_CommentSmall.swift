//  BNIcon_CommentSmall.swift
//  biin
//  Created by Esteban Padilla on 1/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_CommentSmall:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(9.5, 3.79))
        bezierPath.addCurveToPoint(CGPointMake(4.75, 7.51), controlPoint1: CGPointMake(9.5, 5.85), controlPoint2: CGPointMake(7.37, 7.51))
        bezierPath.addCurveToPoint(CGPointMake(3.11, 7.24), controlPoint1: CGPointMake(4.16, 7.51), controlPoint2: CGPointMake(3.63, 7.39))
        bezierPath.addLineToPoint(CGPointMake(0.36, 8.5))
        bezierPath.addLineToPoint(CGPointMake(1.47, 6.45))
        bezierPath.addCurveToPoint(CGPointMake(0, 3.79), controlPoint1: CGPointMake(0.59, 5.78), controlPoint2: CGPointMake(0, 4.83))
        bezierPath.addCurveToPoint(CGPointMake(4.75, 0), controlPoint1: CGPointMake(0, 1.73), controlPoint2: CGPointMake(2.13, 0))
        bezierPath.addCurveToPoint(CGPointMake(9.5, 3.79), controlPoint1: CGPointMake(7.37, 0), controlPoint2: CGPointMake(9.5, 1.73))
        bezierPath.closePath()
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezierPath.lineWidth = 1.5
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}