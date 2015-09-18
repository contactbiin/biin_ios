//  BNIcon_NotificationMedium.swift
//  biin
//  Created by Esteban Padilla on 1/21/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_NotificationMedium:BNIcon {
    
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
        
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(21.2, 16.48))
        bezier2Path.addLineToPoint(CGPointMake(21.2, 10.78))
        bezier2Path.addCurveToPoint(CGPointMake(15.48, 2.59), controlPoint1: CGPointMake(21.2, 7.05), controlPoint2: CGPointMake(18.94, 3.84))
        bezier2Path.addCurveToPoint(CGPointMake(12.3, 0), controlPoint1: CGPointMake(15.27, 1.09), controlPoint2: CGPointMake(13.92, 0))
        bezier2Path.addCurveToPoint(CGPointMake(9.12, 2.59), controlPoint1: CGPointMake(10.68, 0), controlPoint2: CGPointMake(9.39, 1.14))
        bezier2Path.addCurveToPoint(CGPointMake(3.4, 10.78), controlPoint1: CGPointMake(5.66, 3.84), controlPoint2: CGPointMake(3.4, 7))
        bezier2Path.addLineToPoint(CGPointMake(3.4, 16.48))
        bezier2Path.addCurveToPoint(CGPointMake(0, 19.33), controlPoint1: CGPointMake(3.4, 18.19), controlPoint2: CGPointMake(1.73, 18.92))
        bezier2Path.addLineToPoint(CGPointMake(24.6, 19.33))
        bezier2Path.addCurveToPoint(CGPointMake(21.2, 16.48), controlPoint1: CGPointMake(22.93, 18.92), controlPoint2: CGPointMake(21.2, 18.19))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(15.27, 19.33))
        bezierPath.addCurveToPoint(CGPointMake(12.3, 22.6), controlPoint1: CGPointMake(15.27, 21.04), controlPoint2: CGPointMake(14.08, 22.6))
        bezierPath.addCurveToPoint(CGPointMake(9.33, 19.33), controlPoint1: CGPointMake(10.52, 22.6), controlPoint2: CGPointMake(9.33, 21.04))
        bezierPath.lineCapStyle = CGLineCap.Round;
        
        bezierPath.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
