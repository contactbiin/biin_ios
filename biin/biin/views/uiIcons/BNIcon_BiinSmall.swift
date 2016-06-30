//  BNIcon_BiinSmall.swift
//  biin
//  Created by Esteban Padilla on 1/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_BiinSmall:BNIcon {
    
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
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(1.75, 2.72))
        bezierPath.addCurveToPoint(CGPointMake(3.25, 2.37), controlPoint1: CGPointMake(2.2, 2.5), controlPoint2: CGPointMake(2.71, 2.37))
        bezierPath.addCurveToPoint(CGPointMake(6.5, 5.44), controlPoint1: CGPointMake(5.04, 2.37), controlPoint2: CGPointMake(6.5, 3.75))
        bezierPath.addCurveToPoint(CGPointMake(3.25, 8.5), controlPoint1: CGPointMake(6.5, 7.13), controlPoint2: CGPointMake(5.05, 8.5))
        bezierPath.addCurveToPoint(CGPointMake(0, 5.44), controlPoint1: CGPointMake(1.46, 8.5), controlPoint2: CGPointMake(0, 7.13))
        bezierPath.addLineToPoint(CGPointMake(0, 0))
        bezierPath.lineCapStyle = CGLineCap.Round;
        
        bezierPath.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 1.5
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}