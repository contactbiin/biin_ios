//  BNIcon_MoviesMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_MoviesMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(25, 9.77))
        bezier2Path.addCurveToPoint(CGPointMake(25.83, 7.69), controlPoint1: CGPointMake(25, 8.99), controlPoint2: CGPointMake(25.31, 8.21))
        bezier2Path.addCurveToPoint(CGPointMake(25.83, 7.08), controlPoint1: CGPointMake(26, 7.51), controlPoint2: CGPointMake(26, 7.25))
        bezier2Path.addLineToPoint(CGPointMake(18.89, 0.13))
        bezier2Path.addCurveToPoint(CGPointMake(18.55, 0), controlPoint1: CGPointMake(18.81, 0.04), controlPoint2: CGPointMake(18.68, 0))
        bezier2Path.addCurveToPoint(CGPointMake(18.24, 0.22), controlPoint1: CGPointMake(18.42, 0), controlPoint2: CGPointMake(18.29, 0.09))
        bezier2Path.addCurveToPoint(CGPointMake(16.42, 1), controlPoint1: CGPointMake(17.94, 0.69), controlPoint2: CGPointMake(17.25, 1))
        bezier2Path.addCurveToPoint(CGPointMake(14.17, 0.17), controlPoint1: CGPointMake(15.56, 1), controlPoint2: CGPointMake(14.69, 0.69))
        bezier2Path.addCurveToPoint(CGPointMake(13.56, 0.17), controlPoint1: CGPointMake(14, 0), controlPoint2: CGPointMake(13.74, 0))
        bezier2Path.addLineToPoint(CGPointMake(0.13, 13.64))
        bezier2Path.addCurveToPoint(CGPointMake(0.13, 14.24), controlPoint1: CGPointMake(-0.04, 13.81), controlPoint2: CGPointMake(-0.04, 14.07))
        bezier2Path.addCurveToPoint(CGPointMake(0.95, 16.33), controlPoint1: CGPointMake(0.65, 14.77), controlPoint2: CGPointMake(0.95, 15.55))
        bezier2Path.addCurveToPoint(CGPointMake(0.13, 18.41), controlPoint1: CGPointMake(0.95, 17.11), controlPoint2: CGPointMake(0.65, 17.89))
        bezier2Path.addCurveToPoint(CGPointMake(0.13, 19.02), controlPoint1: CGPointMake(-0.04, 18.59), controlPoint2: CGPointMake(-0.04, 18.85))
        bezier2Path.addLineToPoint(CGPointMake(7.06, 25.97))
        bezier2Path.addCurveToPoint(CGPointMake(7.67, 25.97), controlPoint1: CGPointMake(7.24, 26.14), controlPoint2: CGPointMake(7.5, 26.14))
        bezier2Path.addCurveToPoint(CGPointMake(9.75, 25.14), controlPoint1: CGPointMake(8.19, 25.45), controlPoint2: CGPointMake(8.97, 25.14))
        bezier2Path.addCurveToPoint(CGPointMake(11.83, 25.97), controlPoint1: CGPointMake(10.53, 25.14), controlPoint2: CGPointMake(11.31, 25.45))
        bezier2Path.addCurveToPoint(CGPointMake(12.13, 26.1), controlPoint1: CGPointMake(11.92, 26.06), controlPoint2: CGPointMake(12.05, 26.1))
        bezier2Path.addCurveToPoint(CGPointMake(12.44, 25.97), controlPoint1: CGPointMake(12.26, 26.1), controlPoint2: CGPointMake(12.35, 26.06))
        bezier2Path.addLineToPoint(CGPointMake(25.87, 12.51))
        bezier2Path.addCurveToPoint(CGPointMake(26, 12.2), controlPoint1: CGPointMake(25.96, 12.42), controlPoint2: CGPointMake(26, 12.33))
        bezier2Path.addCurveToPoint(CGPointMake(25.87, 11.9), controlPoint1: CGPointMake(26, 12.07), controlPoint2: CGPointMake(25.96, 11.99))
        bezier2Path.addCurveToPoint(CGPointMake(25, 9.77), controlPoint1: CGPointMake(25.31, 11.33), controlPoint2: CGPointMake(25, 10.55))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(21.58, 12.38))
        bezier2Path.addLineToPoint(CGPointMake(12.31, 21.67))
        bezier2Path.addCurveToPoint(CGPointMake(10.79, 22.32), controlPoint1: CGPointMake(11.92, 22.06), controlPoint2: CGPointMake(11.35, 22.32))
        bezier2Path.addCurveToPoint(CGPointMake(9.27, 21.67), controlPoint1: CGPointMake(10.23, 22.32), controlPoint2: CGPointMake(9.66, 22.1))
        bezier2Path.addLineToPoint(CGPointMake(4.33, 16.72))
        bezier2Path.addCurveToPoint(CGPointMake(3.68, 15.2), controlPoint1: CGPointMake(3.94, 16.33), controlPoint2: CGPointMake(3.68, 15.76))
        bezier2Path.addCurveToPoint(CGPointMake(4.33, 13.68), controlPoint1: CGPointMake(3.68, 14.64), controlPoint2: CGPointMake(3.9, 14.07))
        bezier2Path.addLineToPoint(CGPointMake(13.56, 4.43))
        bezier2Path.addCurveToPoint(CGPointMake(15.08, 3.78), controlPoint1: CGPointMake(13.95, 4.04), controlPoint2: CGPointMake(14.52, 3.78))
        bezier2Path.addCurveToPoint(CGPointMake(16.6, 4.43), controlPoint1: CGPointMake(15.64, 3.78), controlPoint2: CGPointMake(16.21, 4))
        bezier2Path.addLineToPoint(CGPointMake(21.49, 9.34))
        bezier2Path.addCurveToPoint(CGPointMake(22.14, 10.86), controlPoint1: CGPointMake(21.88, 9.73), controlPoint2: CGPointMake(22.14, 10.29))
        bezier2Path.addCurveToPoint(CGPointMake(21.58, 12.38), controlPoint1: CGPointMake(22.19, 11.42), controlPoint2: CGPointMake(21.97, 11.99))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(16.03, 4.99))
        bezier4Path.addCurveToPoint(CGPointMake(15.12, 4.6), controlPoint1: CGPointMake(15.77, 4.73), controlPoint2: CGPointMake(15.47, 4.6))
        bezier4Path.addCurveToPoint(CGPointMake(14.21, 4.99), controlPoint1: CGPointMake(14.78, 4.6), controlPoint2: CGPointMake(14.43, 4.73))
        bezier4Path.addLineToPoint(CGPointMake(4.94, 14.29))
        bezier4Path.addCurveToPoint(CGPointMake(4.55, 15.2), controlPoint1: CGPointMake(4.68, 14.55), controlPoint2: CGPointMake(4.55, 14.85))
        bezier4Path.addCurveToPoint(CGPointMake(4.94, 16.11), controlPoint1: CGPointMake(4.55, 15.55), controlPoint2: CGPointMake(4.68, 15.89))
        bezier4Path.addLineToPoint(CGPointMake(9.84, 21.02))
        bezier4Path.addCurveToPoint(CGPointMake(11.66, 21.02), controlPoint1: CGPointMake(10.31, 21.5), controlPoint2: CGPointMake(11.18, 21.5))
        bezier4Path.addLineToPoint(CGPointMake(20.89, 11.77))
        bezier4Path.addCurveToPoint(CGPointMake(21.28, 10.86), controlPoint1: CGPointMake(21.15, 11.51), controlPoint2: CGPointMake(21.28, 11.2))
        bezier4Path.addCurveToPoint(CGPointMake(20.89, 9.94), controlPoint1: CGPointMake(21.28, 10.51), controlPoint2: CGPointMake(21.15, 10.16))
        bezier4Path.addLineToPoint(CGPointMake(16.03, 4.99))
        bezier4Path.closePath()
        bezier4Path.moveToPoint(CGPointMake(8.93, 15.07))
        bezier4Path.addCurveToPoint(CGPointMake(8.62, 15.2), controlPoint1: CGPointMake(8.84, 15.16), controlPoint2: CGPointMake(8.71, 15.2))
        bezier4Path.addCurveToPoint(CGPointMake(8.32, 15.07), controlPoint1: CGPointMake(8.49, 15.2), controlPoint2: CGPointMake(8.41, 15.16))
        bezier4Path.addCurveToPoint(CGPointMake(8.32, 14.46), controlPoint1: CGPointMake(8.15, 14.9), controlPoint2: CGPointMake(8.15, 14.64))
        bezier4Path.addLineToPoint(CGPointMake(14.82, 7.95))
        bezier4Path.addCurveToPoint(CGPointMake(15.43, 7.95), controlPoint1: CGPointMake(14.99, 7.77), controlPoint2: CGPointMake(15.25, 7.77))
        bezier4Path.addCurveToPoint(CGPointMake(15.43, 8.56), controlPoint1: CGPointMake(15.6, 8.12), controlPoint2: CGPointMake(15.6, 8.38))
        bezier4Path.addLineToPoint(CGPointMake(8.93, 15.07))
        bezier4Path.closePath()
        bezier4Path.moveToPoint(CGPointMake(16.29, 12.46))
        bezier4Path.addLineToPoint(CGPointMake(12.83, 15.94))
        bezier4Path.addCurveToPoint(CGPointMake(12.52, 16.07), controlPoint1: CGPointMake(12.74, 16.02), controlPoint2: CGPointMake(12.61, 16.07))
        bezier4Path.addCurveToPoint(CGPointMake(12.22, 15.94), controlPoint1: CGPointMake(12.39, 16.07), controlPoint2: CGPointMake(12.31, 16.02))
        bezier4Path.addCurveToPoint(CGPointMake(12.22, 15.33), controlPoint1: CGPointMake(12.05, 15.76), controlPoint2: CGPointMake(12.05, 15.5))
        bezier4Path.addLineToPoint(CGPointMake(15.69, 11.86))
        bezier4Path.addCurveToPoint(CGPointMake(16.29, 11.86), controlPoint1: CGPointMake(15.86, 11.68), controlPoint2: CGPointMake(16.12, 11.68))
        bezier4Path.addCurveToPoint(CGPointMake(16.29, 12.46), controlPoint1: CGPointMake(16.47, 12.03), controlPoint2: CGPointMake(16.47, 12.29))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        CGContextRestoreGState(context)
    }
}
