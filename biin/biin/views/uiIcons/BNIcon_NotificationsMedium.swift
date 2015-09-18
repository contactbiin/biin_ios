//  BNIcon_NotificationsMedium.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_NotificationsMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(22.92, 18.67))
        bezier2Path.addLineToPoint(CGPointMake(22.92, 12.21))
        bezier2Path.addCurveToPoint(CGPointMake(16.74, 2.94), controlPoint1: CGPointMake(22.92, 7.99), controlPoint2: CGPointMake(20.47, 4.34))
        bezier2Path.addCurveToPoint(CGPointMake(13.3, 0), controlPoint1: CGPointMake(16.51, 1.23), controlPoint2: CGPointMake(15.05, 0))
        bezier2Path.addCurveToPoint(CGPointMake(9.86, 2.94), controlPoint1: CGPointMake(11.55, 0), controlPoint2: CGPointMake(10.15, 1.29))
        bezier2Path.addCurveToPoint(CGPointMake(3.67, 12.21), controlPoint1: CGPointMake(6.12, 4.34), controlPoint2: CGPointMake(3.67, 7.93))
        bezier2Path.addLineToPoint(CGPointMake(3.67, 18.67))
        bezier2Path.addCurveToPoint(CGPointMake(0, 21.9), controlPoint1: CGPointMake(3.67, 20.61), controlPoint2: CGPointMake(1.87, 21.43))
        bezier2Path.addLineToPoint(CGPointMake(26.6, 21.9))
        bezier2Path.addCurveToPoint(CGPointMake(22.92, 18.67), controlPoint1: CGPointMake(24.79, 21.43), controlPoint2: CGPointMake(22.92, 20.61))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(16.51, 21.9))
        bezier4Path.addCurveToPoint(CGPointMake(13.3, 25.6), controlPoint1: CGPointMake(16.51, 23.84), controlPoint2: CGPointMake(15.22, 25.6))
        bezier4Path.addCurveToPoint(CGPointMake(10.09, 21.9), controlPoint1: CGPointMake(11.38, 25.6), controlPoint2: CGPointMake(10.09, 23.84))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        bezier4Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}

