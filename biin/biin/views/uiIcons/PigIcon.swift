//  PigIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class PigIcon:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(32.08, 10.35))
        bezier2Path.addCurveToPoint(CGPointMake(31.51, 10.93), controlPoint1: CGPointMake(31.8, 10.35), controlPoint2: CGPointMake(31.51, 10.56))
        bezier2Path.addCurveToPoint(CGPointMake(29.86, 13.1), controlPoint1: CGPointMake(31.51, 12.01), controlPoint2: CGPointMake(30.79, 12.81))
        bezier2Path.addCurveToPoint(CGPointMake(16.33, 2.17), controlPoint1: CGPointMake(29.51, 7.02), controlPoint2: CGPointMake(23.56, 2.17))
        bezier2Path.addCurveToPoint(CGPointMake(13.25, 2.39), controlPoint1: CGPointMake(15.33, 2.17), controlPoint2: CGPointMake(14.25, 2.17))
        bezier2Path.addCurveToPoint(CGPointMake(8.81, -0), controlPoint1: CGPointMake(12.25, 0.87), controlPoint2: CGPointMake(10.6, -0))
        bezier2Path.addCurveToPoint(CGPointMake(6.16, 0.72), controlPoint1: CGPointMake(7.88, -0), controlPoint2: CGPointMake(6.95, 0.22))
        bezier2Path.addCurveToPoint(CGPointMake(5.87, 1.23), controlPoint1: CGPointMake(6.02, 0.8), controlPoint2: CGPointMake(5.87, 1.01))
        bezier2Path.addCurveToPoint(CGPointMake(6.16, 1.74), controlPoint1: CGPointMake(5.87, 1.45), controlPoint2: CGPointMake(5.94, 1.59))
        bezier2Path.addCurveToPoint(CGPointMake(8.16, 4.49), controlPoint1: CGPointMake(7.23, 2.32), controlPoint2: CGPointMake(7.95, 3.33))
        bezier2Path.addCurveToPoint(CGPointMake(2.86, 12.16), controlPoint1: CGPointMake(5.37, 6.3), controlPoint2: CGPointMake(3.44, 9.12))
        bezier2Path.addLineToPoint(CGPointMake(0.57, 12.16))
        bezier2Path.addCurveToPoint(CGPointMake(0, 12.74), controlPoint1: CGPointMake(0.29, 12.16), controlPoint2: CGPointMake(0, 12.37))
        bezier2Path.addLineToPoint(CGPointMake(0, 18.24))
        bezier2Path.addCurveToPoint(CGPointMake(0.57, 18.81), controlPoint1: CGPointMake(0, 18.52), controlPoint2: CGPointMake(0.21, 18.81))
        bezier2Path.addLineToPoint(CGPointMake(4.01, 18.81))
        bezier2Path.addCurveToPoint(CGPointMake(10.89, 24.6), controlPoint1: CGPointMake(5.37, 21.56), controlPoint2: CGPointMake(7.73, 23.59))
        bezier2Path.addLineToPoint(CGPointMake(10.89, 28.15))
        bezier2Path.addCurveToPoint(CGPointMake(11.46, 28.73), controlPoint1: CGPointMake(10.89, 28.44), controlPoint2: CGPointMake(11.1, 28.73))
        bezier2Path.addCurveToPoint(CGPointMake(12.03, 28.15), controlPoint1: CGPointMake(11.74, 28.73), controlPoint2: CGPointMake(12.03, 28.51))
        bezier2Path.addLineToPoint(CGPointMake(12.03, 24.89))
        bezier2Path.addCurveToPoint(CGPointMake(16.4, 25.4), controlPoint1: CGPointMake(13.39, 25.25), controlPoint2: CGPointMake(14.82, 25.4))
        bezier2Path.addCurveToPoint(CGPointMake(20.77, 24.82), controlPoint1: CGPointMake(17.9, 25.4), controlPoint2: CGPointMake(19.41, 25.18))
        bezier2Path.addLineToPoint(CGPointMake(20.77, 28.22))
        bezier2Path.addCurveToPoint(CGPointMake(21.34, 28.8), controlPoint1: CGPointMake(20.77, 28.51), controlPoint2: CGPointMake(20.98, 28.8))
        bezier2Path.addCurveToPoint(CGPointMake(21.91, 28.22), controlPoint1: CGPointMake(21.63, 28.8), controlPoint2: CGPointMake(21.91, 28.58))
        bezier2Path.addLineToPoint(CGPointMake(21.91, 24.53))
        bezier2Path.addCurveToPoint(CGPointMake(30.01, 14.47), controlPoint1: CGPointMake(26.5, 22.79), controlPoint2: CGPointMake(29.79, 18.96))
        bezier2Path.addCurveToPoint(CGPointMake(32.8, 11.22), controlPoint1: CGPointMake(31.58, 14.26), controlPoint2: CGPointMake(32.8, 12.88))
        bezier2Path.addCurveToPoint(CGPointMake(32.08, 10.35), controlPoint1: CGPointMake(32.59, 10.64), controlPoint2: CGPointMake(32.37, 10.35))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(23.2, 8.54))
        bezier2Path.addCurveToPoint(CGPointMake(22.77, 8.76), controlPoint1: CGPointMake(23.13, 8.68), controlPoint2: CGPointMake(22.92, 8.76))
        bezier2Path.addCurveToPoint(CGPointMake(22.42, 8.61), controlPoint1: CGPointMake(22.63, 8.76), controlPoint2: CGPointMake(22.56, 8.76))
        bezier2Path.addCurveToPoint(CGPointMake(15.68, 6.51), controlPoint1: CGPointMake(20.48, 7.16), controlPoint2: CGPointMake(17.98, 6.37))
        bezier2Path.addCurveToPoint(CGPointMake(15.11, 6.01), controlPoint1: CGPointMake(15.4, 6.51), controlPoint2: CGPointMake(15.11, 6.3))
        bezier2Path.addCurveToPoint(CGPointMake(15.61, 5.43), controlPoint1: CGPointMake(15.11, 5.72), controlPoint2: CGPointMake(15.33, 5.43))
        bezier2Path.addCurveToPoint(CGPointMake(23.06, 7.74), controlPoint1: CGPointMake(18.12, 5.28), controlPoint2: CGPointMake(20.91, 6.15))
        bezier2Path.addCurveToPoint(CGPointMake(23.2, 8.54), controlPoint1: CGPointMake(23.35, 7.96), controlPoint2: CGPointMake(23.42, 8.25))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        
        CGContextRestoreGState(context)    }
    
}
