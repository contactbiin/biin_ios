//  PinIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/2/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class PinIcon:BNIcon {
    
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
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(47.43, 17.62))
        bezierPath.addLineToPoint(CGPointMake(30.23, 0.41))
        bezierPath.addCurveToPoint(CGPointMake(28.16, 0.41), controlPoint1: CGPointMake(29.68, -0.14), controlPoint2: CGPointMake(28.71, -0.14))
        bezierPath.addLineToPoint(CGPointMake(23.38, 5.2))
        bezierPath.addCurveToPoint(CGPointMake(23.38, 7.27), controlPoint1: CGPointMake(22.81, 5.77), controlPoint2: CGPointMake(22.81, 6.7))
        bezierPath.addLineToPoint(CGPointMake(25.21, 9.1))
        bezierPath.addLineToPoint(CGPointMake(15.2, 19.11))
        bezierPath.addLineToPoint(CGPointMake(5.29, 19.11))
        bezierPath.addCurveToPoint(CGPointMake(4.25, 19.53), controlPoint1: CGPointMake(4.9, 19.11), controlPoint2: CGPointMake(4.53, 19.26))
        bezierPath.addLineToPoint(CGPointMake(0.43, 23.36))
        bezierPath.addCurveToPoint(CGPointMake(0, 24.39), controlPoint1: CGPointMake(0.15, 23.63), controlPoint2: CGPointMake(0, 24))
        bezierPath.addCurveToPoint(CGPointMake(0.43, 25.43), controlPoint1: CGPointMake(0, 24.78), controlPoint2: CGPointMake(0.15, 25.15))
        bezierPath.addLineToPoint(CGPointMake(10.39, 35.39))
        bezierPath.addLineToPoint(CGPointMake(0.43, 45.35))
        bezierPath.addLineToPoint(CGPointMake(2.5, 47.42))
        bezierPath.addLineToPoint(CGPointMake(12.46, 37.46))
        bezierPath.addLineToPoint(CGPointMake(22.42, 47.42))
        bezierPath.addCurveToPoint(CGPointMake(23.45, 47.85), controlPoint1: CGPointMake(22.7, 47.7), controlPoint2: CGPointMake(23.08, 47.85))
        bezierPath.addCurveToPoint(CGPointMake(24.49, 47.42), controlPoint1: CGPointMake(23.83, 47.85), controlPoint2: CGPointMake(24.2, 47.7))
        bezierPath.addLineToPoint(CGPointMake(28.31, 43.59))
        bezierPath.addCurveToPoint(CGPointMake(28.74, 42.56), controlPoint1: CGPointMake(28.59, 43.32), controlPoint2: CGPointMake(28.74, 42.95))
        bezierPath.addLineToPoint(CGPointMake(28.74, 32.65))
        bezierPath.addLineToPoint(CGPointMake(38.75, 22.64))
        bezierPath.addLineToPoint(CGPointMake(40.58, 24.47))
        bezierPath.addCurveToPoint(CGPointMake(41.61, 24.9), controlPoint1: CGPointMake(40.85, 24.75), controlPoint2: CGPointMake(41.23, 24.9))
        bezierPath.addCurveToPoint(CGPointMake(42.65, 24.47), controlPoint1: CGPointMake(42, 24.9), controlPoint2: CGPointMake(42.38, 24.75))
        bezierPath.addLineToPoint(CGPointMake(47.43, 19.69))
        bezierPath.addCurveToPoint(CGPointMake(47.86, 18.66), controlPoint1: CGPointMake(47.71, 19.42), controlPoint2: CGPointMake(47.86, 19.05))
        bezierPath.addCurveToPoint(CGPointMake(47.43, 17.62), controlPoint1: CGPointMake(47.86, 18.27), controlPoint2: CGPointMake(47.71, 17.9))
        bezierPath.closePath()
        
        
        if isFilled {
            color!.setFill()
            bezierPath.fill()
        }
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        CGContextRestoreGState(context)

    }
}