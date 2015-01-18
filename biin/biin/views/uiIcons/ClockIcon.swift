//  ClockIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/8/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class ClockIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.scale = scale
        super.position = position
        super.stroke = stroke
        super.isFilled = isFilled
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(30.65, 11.86))
        bezier2Path.addLineToPoint(CGPointMake(32.69, 9.95))
        bezier2Path.addLineToPoint(CGPointMake(33.06, 10.3))
        bezier2Path.addCurveToPoint(CGPointMake(33.55, 10.47), controlPoint1: CGPointMake(33.18, 10.41), controlPoint2: CGPointMake(33.37, 10.47))
        bezier2Path.addCurveToPoint(CGPointMake(34.04, 10.3), controlPoint1: CGPointMake(33.74, 10.47), controlPoint2: CGPointMake(33.92, 10.41))
        bezier2Path.addCurveToPoint(CGPointMake(34.04, 9.37), controlPoint1: CGPointMake(34.29, 10.07), controlPoint2: CGPointMake(34.29, 9.6))
        bezier2Path.addLineToPoint(CGPointMake(32.26, 7.69))
        bezier2Path.addCurveToPoint(CGPointMake(31.27, 7.69), controlPoint1: CGPointMake(32.01, 7.46), controlPoint2: CGPointMake(31.52, 7.46))
        bezier2Path.addCurveToPoint(CGPointMake(31.27, 8.62), controlPoint1: CGPointMake(31.02, 7.93), controlPoint2: CGPointMake(31.02, 8.39))
        bezier2Path.addLineToPoint(CGPointMake(31.64, 8.97))
        bezier2Path.addLineToPoint(CGPointMake(29.6, 10.88))
        bezier2Path.addCurveToPoint(CGPointMake(17.7, 6.59), controlPoint1: CGPointMake(26.46, 8.21), controlPoint2: CGPointMake(22.33, 6.59))
        bezier2Path.addCurveToPoint(CGPointMake(0, 23.2), controlPoint1: CGPointMake(7.96, 6.59), controlPoint2: CGPointMake(0, 14.06))
        bezier2Path.addCurveToPoint(CGPointMake(17.7, 39.8), controlPoint1: CGPointMake(0, 32.34), controlPoint2: CGPointMake(7.96, 39.8))
        bezier2Path.addCurveToPoint(CGPointMake(35.4, 23.2), controlPoint1: CGPointMake(27.44, 39.8), controlPoint2: CGPointMake(35.4, 32.34))
        bezier2Path.addCurveToPoint(CGPointMake(30.65, 11.86), controlPoint1: CGPointMake(35.46, 18.8), controlPoint2: CGPointMake(33.61, 14.81))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(12.77, 1.27))
        bezier4Path.addLineToPoint(CGPointMake(14.86, 1.27))
        bezier4Path.addLineToPoint(CGPointMake(14.86, 4.57))
        bezier4Path.addCurveToPoint(CGPointMake(15.54, 5.21), controlPoint1: CGPointMake(14.86, 4.92), controlPoint2: CGPointMake(15.17, 5.21))
        bezier4Path.addLineToPoint(CGPointMake(19.8, 5.21))
        bezier4Path.addCurveToPoint(CGPointMake(20.48, 4.57), controlPoint1: CGPointMake(20.17, 5.21), controlPoint2: CGPointMake(20.48, 4.92))
        bezier4Path.addLineToPoint(CGPointMake(20.48, 1.27))
        bezier4Path.addLineToPoint(CGPointMake(22.57, 1.27))
        bezier4Path.addCurveToPoint(CGPointMake(23.25, 0.64), controlPoint1: CGPointMake(22.94, 1.27), controlPoint2: CGPointMake(23.25, 0.98))
        bezier4Path.addCurveToPoint(CGPointMake(22.57, 0), controlPoint1: CGPointMake(23.25, 0.29), controlPoint2: CGPointMake(22.94, 0))
        bezier4Path.addLineToPoint(CGPointMake(19.74, 0))
        bezier4Path.addLineToPoint(CGPointMake(15.48, 0))
        bezier4Path.addLineToPoint(CGPointMake(12.64, 0))
        bezier4Path.addCurveToPoint(CGPointMake(11.96, 0.64), controlPoint1: CGPointMake(12.27, 0), controlPoint2: CGPointMake(11.96, 0.29))
        bezier4Path.addCurveToPoint(CGPointMake(12.77, 1.27), controlPoint1: CGPointMake(12.03, 0.98), controlPoint2: CGPointMake(12.4, 1.27))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}
