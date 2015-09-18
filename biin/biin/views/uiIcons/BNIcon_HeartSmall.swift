//  BNIcon_HeartSmall.swift
//  biin
//  Created by Esteban Padilla on 8/21/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_HeartSmall:BNIcon {
    
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
        bezierPath.moveToPoint(CGPointMake(6.2, 0))
        bezierPath.addCurveToPoint(CGPointMake(4.25, 1.04), controlPoint1: CGPointMake(5.38, 0), controlPoint2: CGPointMake(4.66, 0.42))
        bezierPath.addCurveToPoint(CGPointMake(2.3, 0), controlPoint1: CGPointMake(3.84, 0.42), controlPoint2: CGPointMake(3.12, 0))
        bezierPath.addCurveToPoint(CGPointMake(0, 2.22), controlPoint1: CGPointMake(1.03, 0), controlPoint2: CGPointMake(0, 0.99))
        bezierPath.addCurveToPoint(CGPointMake(1.59, 5.28), controlPoint1: CGPointMake(0, 3.44), controlPoint2: CGPointMake(0.71, 4.43))
        bezierPath.addCurveToPoint(CGPointMake(4.25, 7.5), controlPoint1: CGPointMake(2.48, 6.14), controlPoint2: CGPointMake(3.9, 7.16))
        bezierPath.addCurveToPoint(CGPointMake(6.91, 5.28), controlPoint1: CGPointMake(4.6, 7.16), controlPoint2: CGPointMake(6.02, 6.14))
        bezierPath.addCurveToPoint(CGPointMake(8.5, 2.22), controlPoint1: CGPointMake(7.79, 4.43), controlPoint2: CGPointMake(8.5, 3.44))
        bezierPath.addCurveToPoint(CGPointMake(6.2, 0), controlPoint1: CGPointMake(8.5, 0.99), controlPoint2: CGPointMake(7.47, 0))
        bezierPath.addLineToPoint(CGPointMake(6.2, 0))
        bezierPath.closePath()
        bezierPath.lineCapStyle = CGLineCap.Round;
        
        bezierPath.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 1.5
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}
