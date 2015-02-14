//  BNIcon_ShoeMedium.swift
//  biin
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ShoeMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(26.8, 4.14))
        bezier2Path.addLineToPoint(CGPointMake(16.63, 4.14))
        bezier2Path.addCurveToPoint(CGPointMake(14.5, 6.22), controlPoint1: CGPointMake(16.63, 5.54), controlPoint2: CGPointMake(15.94, 6.22))
        bezier2Path.addLineToPoint(CGPointMake(10.22, 6.22))
        bezier2Path.addCurveToPoint(CGPointMake(9.04, 8.44), controlPoint1: CGPointMake(9.9, 6.22), controlPoint2: CGPointMake(9.15, 6.89))
        bezier2Path.addLineToPoint(CGPointMake(12.25, 9.64))
        bezier2Path.addLineToPoint(CGPointMake(14.12, 7.87))
        bezier2Path.addCurveToPoint(CGPointMake(14.87, 7.87), controlPoint1: CGPointMake(14.33, 7.67), controlPoint2: CGPointMake(14.66, 7.67))
        bezier2Path.addCurveToPoint(CGPointMake(14.87, 8.6), controlPoint1: CGPointMake(15.08, 8.08), controlPoint2: CGPointMake(15.08, 8.39))
        bezier2Path.addLineToPoint(CGPointMake(13.37, 10))
        bezier2Path.addLineToPoint(CGPointMake(14.66, 10.47))
        bezier2Path.addCurveToPoint(CGPointMake(14.76, 10.31), controlPoint1: CGPointMake(14.66, 10.41), controlPoint2: CGPointMake(14.71, 10.36))
        bezier2Path.addLineToPoint(CGPointMake(16.85, 8.34))
        bezier2Path.addCurveToPoint(CGPointMake(17.6, 8.34), controlPoint1: CGPointMake(17.06, 8.13), controlPoint2: CGPointMake(17.38, 8.13))
        bezier2Path.addCurveToPoint(CGPointMake(17.6, 9.07), controlPoint1: CGPointMake(17.81, 8.55), controlPoint2: CGPointMake(17.81, 8.86))
        bezier2Path.addLineToPoint(CGPointMake(15.73, 10.83))
        bezier2Path.addLineToPoint(CGPointMake(19.68, 12.28))
        bezier2Path.addCurveToPoint(CGPointMake(19.9, 12.33), controlPoint1: CGPointMake(19.74, 12.28), controlPoint2: CGPointMake(19.79, 12.33))
        bezier2Path.addCurveToPoint(CGPointMake(20.22, 12.23), controlPoint1: CGPointMake(20, 12.33), controlPoint2: CGPointMake(20.11, 12.28))
        bezier2Path.addCurveToPoint(CGPointMake(20.43, 11.81), controlPoint1: CGPointMake(20.38, 12.12), controlPoint2: CGPointMake(20.43, 11.97))
        bezier2Path.addCurveToPoint(CGPointMake(24.18, 10.26), controlPoint1: CGPointMake(20.43, 11.03), controlPoint2: CGPointMake(21.61, 10.26))
        bezier2Path.addCurveToPoint(CGPointMake(27.92, 11.81), controlPoint1: CGPointMake(26.42, 10.26), controlPoint2: CGPointMake(27.92, 11.19))
        bezier2Path.addCurveToPoint(CGPointMake(28.46, 12.33), controlPoint1: CGPointMake(27.92, 12.12), controlPoint2: CGPointMake(28.13, 12.33))
        bezier2Path.addLineToPoint(CGPointMake(30.06, 12.33))
        bezier2Path.addCurveToPoint(CGPointMake(32.2, 10.26), controlPoint1: CGPointMake(31.4, 12.33), controlPoint2: CGPointMake(32.2, 11.55))
        bezier2Path.addLineToPoint(CGPointMake(32.2, 8.19))
        bezier2Path.addCurveToPoint(CGPointMake(26.8, 4.14), controlPoint1: CGPointMake(27.81, 8.13), controlPoint2: CGPointMake(26.96, 5.65))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Group 2
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(0, 18.55))
        bezier4Path.addLineToPoint(CGPointMake(0, 21.66))
        bezier4Path.addLineToPoint(CGPointMake(4.21, 21.66))
        bezier4Path.addCurveToPoint(CGPointMake(0, 18.55), controlPoint1: CGPointMake(4.11, 20.2), controlPoint2: CGPointMake(3.15, 18.65))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(30.61, 20.15))
        bezier6Path.addLineToPoint(CGPointMake(24.11, 17.72))
        bezier6Path.addCurveToPoint(CGPointMake(21.87, 20.62), controlPoint1: CGPointMake(23.89, 19.58), controlPoint2: CGPointMake(22.88, 20.62))
        bezier6Path.addLineToPoint(CGPointMake(17.6, 20.62))
        bezier6Path.addCurveToPoint(CGPointMake(16.53, 21.66), controlPoint1: CGPointMake(16.8, 20.62), controlPoint2: CGPointMake(16.53, 20.88))
        bezier6Path.addLineToPoint(CGPointMake(32, 21.66))
        bezier6Path.addCurveToPoint(CGPointMake(30.61, 20.15), controlPoint1: CGPointMake(32, 20.98), controlPoint2: CGPointMake(31.52, 20.46))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(0, 25.28))
        bezier8Path.addCurveToPoint(CGPointMake(0.53, 25.8), controlPoint1: CGPointMake(0, 25.59), controlPoint2: CGPointMake(0.21, 25.8))
        bezier8Path.addLineToPoint(CGPointMake(31.47, 25.8))
        bezier8Path.addCurveToPoint(CGPointMake(32, 25.28), controlPoint1: CGPointMake(31.79, 25.8), controlPoint2: CGPointMake(32, 25.59))
        bezier8Path.addLineToPoint(CGPointMake(32, 22.69))
        bezier8Path.addLineToPoint(CGPointMake(0, 22.69))
        bezier8Path.addLineToPoint(CGPointMake(0, 25.28))
        bezier8Path.closePath()
        bezier8Path.miterLimit = 4;
        
        color!.setFill()
        bezier8Path.fill()
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(5.33, 21.66))
        bezier10Path.addLineToPoint(CGPointMake(15.47, 21.66))
        bezier10Path.addCurveToPoint(CGPointMake(17.6, 19.58), controlPoint1: CGPointMake(15.47, 20.26), controlPoint2: CGPointMake(16.16, 19.58))
        bezier10Path.addLineToPoint(CGPointMake(21.87, 19.58))
        bezier10Path.addCurveToPoint(CGPointMake(23.04, 17.36), controlPoint1: CGPointMake(22.19, 19.58), controlPoint2: CGPointMake(22.93, 18.91))
        bezier10Path.addLineToPoint(CGPointMake(19.84, 16.16))
        bezier10Path.addLineToPoint(CGPointMake(17.97, 17.93))
        bezier10Path.addCurveToPoint(CGPointMake(17.6, 18.08), controlPoint1: CGPointMake(17.87, 18.03), controlPoint2: CGPointMake(17.76, 18.08))
        bezier10Path.addCurveToPoint(CGPointMake(17.23, 17.93), controlPoint1: CGPointMake(17.44, 18.08), controlPoint2: CGPointMake(17.33, 18.03))
        bezier10Path.addCurveToPoint(CGPointMake(17.23, 17.2), controlPoint1: CGPointMake(17.01, 17.72), controlPoint2: CGPointMake(17.01, 17.41))
        bezier10Path.addLineToPoint(CGPointMake(18.72, 15.8))
        bezier10Path.addLineToPoint(CGPointMake(17.44, 15.33))
        bezier10Path.addCurveToPoint(CGPointMake(17.33, 15.49), controlPoint1: CGPointMake(17.44, 15.39), controlPoint2: CGPointMake(17.39, 15.44))
        bezier10Path.addLineToPoint(CGPointMake(15.25, 17.46))
        bezier10Path.addCurveToPoint(CGPointMake(14.88, 17.61), controlPoint1: CGPointMake(15.15, 17.56), controlPoint2: CGPointMake(15.04, 17.61))
        bezier10Path.addCurveToPoint(CGPointMake(14.51, 17.46), controlPoint1: CGPointMake(14.72, 17.61), controlPoint2: CGPointMake(14.61, 17.56))
        bezier10Path.addCurveToPoint(CGPointMake(14.51, 16.73), controlPoint1: CGPointMake(14.29, 17.25), controlPoint2: CGPointMake(14.29, 16.94))
        bezier10Path.addLineToPoint(CGPointMake(16.37, 14.97))
        bezier10Path.addLineToPoint(CGPointMake(12.43, 13.52))
        bezier10Path.addCurveToPoint(CGPointMake(12, 13.47), controlPoint1: CGPointMake(12.32, 13.37), controlPoint2: CGPointMake(12.11, 13.37))
        bezier10Path.addCurveToPoint(CGPointMake(11.79, 13.88), controlPoint1: CGPointMake(11.84, 13.57), controlPoint2: CGPointMake(11.79, 13.73))
        bezier10Path.addCurveToPoint(CGPointMake(8.05, 15.44), controlPoint1: CGPointMake(11.79, 14.66), controlPoint2: CGPointMake(10.61, 15.44))
        bezier10Path.addCurveToPoint(CGPointMake(4.32, 13.88), controlPoint1: CGPointMake(5.81, 15.44), controlPoint2: CGPointMake(4.32, 14.51))
        bezier10Path.addCurveToPoint(CGPointMake(3.79, 13.37), controlPoint1: CGPointMake(4.32, 13.57), controlPoint2: CGPointMake(4.11, 13.37))
        bezier10Path.addLineToPoint(CGPointMake(2.19, 13.37))
        bezier10Path.addCurveToPoint(CGPointMake(0.05, 15.44), controlPoint1: CGPointMake(0.85, 13.37), controlPoint2: CGPointMake(0.05, 14.14))
        bezier10Path.addLineToPoint(CGPointMake(0.05, 17.51))
        bezier10Path.addCurveToPoint(CGPointMake(5.33, 21.66), controlPoint1: CGPointMake(4.27, 17.67), controlPoint2: CGPointMake(5.17, 20.15))
        bezier10Path.closePath()
        bezier10Path.miterLimit = 4;
        
        color!.setFill()
        bezier10Path.fill()
        
        
        //// Bezier 12 Drawing
        var bezier12Path = UIBezierPath()
        bezier12Path.moveToPoint(CGPointMake(32, 7.25))
        bezier12Path.addLineToPoint(CGPointMake(32, 4.14))
        bezier12Path.addLineToPoint(CGPointMake(27.79, 4.14))
        bezier12Path.addCurveToPoint(CGPointMake(32, 7.25), controlPoint1: CGPointMake(27.95, 5.6), controlPoint2: CGPointMake(28.91, 7.15))
        bezier12Path.closePath()
        bezier12Path.miterLimit = 4;
        
        color!.setFill()
        bezier12Path.fill()
        
        
        //// Bezier 14 Drawing
        var bezier14Path = UIBezierPath()
        bezier14Path.moveToPoint(CGPointMake(31.47, 0))
        bezier14Path.addLineToPoint(CGPointMake(0.53, 0))
        bezier14Path.addCurveToPoint(CGPointMake(0, 0.52), controlPoint1: CGPointMake(0.21, 0), controlPoint2: CGPointMake(0, 0.21))
        bezier14Path.addLineToPoint(CGPointMake(0, 3.11))
        bezier14Path.addLineToPoint(CGPointMake(32, 3.11))
        bezier14Path.addLineToPoint(CGPointMake(32, 0.52))
        bezier14Path.addCurveToPoint(CGPointMake(31.47, 0), controlPoint1: CGPointMake(32, 0.21), controlPoint2: CGPointMake(31.79, 0))
        bezier14Path.closePath()
        bezier14Path.miterLimit = 4;
        
        color!.setFill()
        bezier14Path.fill()
        
        
        //// Bezier 16 Drawing
        var bezier16Path = UIBezierPath()
        bezier16Path.moveToPoint(CGPointMake(7.95, 8.08))
        bezier16Path.addCurveToPoint(CGPointMake(10.19, 5.18), controlPoint1: CGPointMake(8.16, 6.27), controlPoint2: CGPointMake(9.17, 5.18))
        bezier16Path.addLineToPoint(CGPointMake(14.45, 5.18))
        bezier16Path.addCurveToPoint(CGPointMake(15.52, 4.14), controlPoint1: CGPointMake(15.25, 5.18), controlPoint2: CGPointMake(15.52, 4.92))
        bezier16Path.addLineToPoint(CGPointMake(0.05, 4.14))
        bezier16Path.addCurveToPoint(CGPointMake(1.44, 5.65), controlPoint1: CGPointMake(0.05, 4.82), controlPoint2: CGPointMake(0.53, 5.34))
        bezier16Path.addLineToPoint(CGPointMake(7.95, 8.08))
        bezier16Path.closePath()
        bezier16Path.miterLimit = 4;
        
        color!.setFill()
        bezier16Path.fill()
        
        
        
        
        
        CGContextRestoreGState(context)
    }
}
