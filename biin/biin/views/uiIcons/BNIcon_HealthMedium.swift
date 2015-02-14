//  BNIcon_HealthMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_HealthMedium:BNIcon {
    
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
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(25.04, 15.92))
        bezier2Path.addLineToPoint(CGPointMake(19.36, 12.7))
        bezier2Path.addLineToPoint(CGPointMake(25.04, 9.49))
        bezier2Path.addCurveToPoint(CGPointMake(25.25, 9.23), controlPoint1: CGPointMake(25.12, 9.44), controlPoint2: CGPointMake(25.21, 9.36))
        bezier2Path.addCurveToPoint(CGPointMake(25.21, 8.89), controlPoint1: CGPointMake(25.29, 9.1), controlPoint2: CGPointMake(25.25, 9.02))
        bezier2Path.addLineToPoint(CGPointMake(22.26, 3.77))
        bezier2Path.addCurveToPoint(CGPointMake(21.67, 3.6), controlPoint1: CGPointMake(22.13, 3.56), controlPoint2: CGPointMake(21.88, 3.51))
        bezier2Path.addLineToPoint(CGPointMake(15.99, 6.86))
        bezier2Path.addLineToPoint(CGPointMake(15.99, 0.42))
        bezier2Path.addCurveToPoint(CGPointMake(15.57, 0), controlPoint1: CGPointMake(15.99, 0.17), controlPoint2: CGPointMake(15.82, 0))
        bezier2Path.addLineToPoint(CGPointMake(9.68, 0))
        bezier2Path.addCurveToPoint(CGPointMake(9.26, 0.42), controlPoint1: CGPointMake(9.43, 0), controlPoint2: CGPointMake(9.26, 0.17))
        bezier2Path.addLineToPoint(CGPointMake(9.26, 6.86))
        bezier2Path.addLineToPoint(CGPointMake(3.58, 3.64))
        bezier2Path.addCurveToPoint(CGPointMake(2.99, 3.81), controlPoint1: CGPointMake(3.37, 3.51), controlPoint2: CGPointMake(3.11, 3.6))
        bezier2Path.addLineToPoint(CGPointMake(0.04, 8.94))
        bezier2Path.addCurveToPoint(CGPointMake(0, 9.23), controlPoint1: CGPointMake(0, 9.02), controlPoint2: CGPointMake(0, 9.15))
        bezier2Path.addCurveToPoint(CGPointMake(0.21, 9.49), controlPoint1: CGPointMake(0.04, 9.36), controlPoint2: CGPointMake(0.08, 9.44))
        bezier2Path.addLineToPoint(CGPointMake(5.89, 12.7))
        bezier2Path.addLineToPoint(CGPointMake(0.25, 15.92))
        bezier2Path.addCurveToPoint(CGPointMake(0.04, 16.18), controlPoint1: CGPointMake(0.17, 15.96), controlPoint2: CGPointMake(0.08, 16.05))
        bezier2Path.addCurveToPoint(CGPointMake(0.08, 16.52), controlPoint1: CGPointMake(0, 16.3), controlPoint2: CGPointMake(0.04, 16.39))
        bezier2Path.addLineToPoint(CGPointMake(3.03, 21.64))
        bezier2Path.addCurveToPoint(CGPointMake(3.62, 21.81), controlPoint1: CGPointMake(3.16, 21.85), controlPoint2: CGPointMake(3.41, 21.89))
        bezier2Path.addLineToPoint(CGPointMake(9.26, 18.55))
        bezier2Path.addLineToPoint(CGPointMake(9.26, 24.98))
        bezier2Path.addCurveToPoint(CGPointMake(9.68, 25.41), controlPoint1: CGPointMake(9.26, 25.24), controlPoint2: CGPointMake(9.43, 25.41))
        bezier2Path.addLineToPoint(CGPointMake(15.57, 25.41))
        bezier2Path.addCurveToPoint(CGPointMake(15.99, 24.98), controlPoint1: CGPointMake(15.82, 25.41), controlPoint2: CGPointMake(15.99, 25.24))
        bezier2Path.addLineToPoint(CGPointMake(15.99, 18.55))
        bezier2Path.addLineToPoint(CGPointMake(21.67, 21.77))
        bezier2Path.addCurveToPoint(CGPointMake(22.26, 21.6), controlPoint1: CGPointMake(21.88, 21.89), controlPoint2: CGPointMake(22.13, 21.81))
        bezier2Path.addLineToPoint(CGPointMake(25.21, 16.47))
        bezier2Path.addCurveToPoint(CGPointMake(25.25, 16.13), controlPoint1: CGPointMake(25.25, 16.39), controlPoint2: CGPointMake(25.29, 16.26))
        bezier2Path.addCurveToPoint(CGPointMake(25.04, 15.92), controlPoint1: CGPointMake(25.21, 16.05), controlPoint2: CGPointMake(25.12, 15.96))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        
        CGContextRestoreGState(context)
        
    }
}
