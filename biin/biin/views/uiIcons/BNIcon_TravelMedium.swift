//  BNIcon_TravelMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_TravelMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(21.56, 23.83))
        bezier2Path.addCurveToPoint(CGPointMake(21.12, 24.27), controlPoint1: CGPointMake(21.3, 23.83), controlPoint2: CGPointMake(21.12, 24.01))
        bezier2Path.addCurveToPoint(CGPointMake(20.24, 25.13), controlPoint1: CGPointMake(21.12, 24.74), controlPoint2: CGPointMake(20.72, 25.13))
        bezier2Path.addCurveToPoint(CGPointMake(19.36, 24.27), controlPoint1: CGPointMake(19.76, 25.13), controlPoint2: CGPointMake(19.36, 24.74))
        bezier2Path.addCurveToPoint(CGPointMake(17.16, 22.1), controlPoint1: CGPointMake(19.36, 23.05), controlPoint2: CGPointMake(18.39, 22.1))
        bezier2Path.addLineToPoint(CGPointMake(19.58, 12.87))
        bezier2Path.addLineToPoint(CGPointMake(20.11, 13))
        bezier2Path.addCurveToPoint(CGPointMake(20.2, 13), controlPoint1: CGPointMake(20.15, 13), controlPoint2: CGPointMake(20.2, 13))
        bezier2Path.addCurveToPoint(CGPointMake(20.64, 12.65), controlPoint1: CGPointMake(20.42, 13), controlPoint2: CGPointMake(20.59, 12.87))
        bezier2Path.addCurveToPoint(CGPointMake(20.33, 12.13), controlPoint1: CGPointMake(20.68, 12.44), controlPoint2: CGPointMake(20.55, 12.18))
        bezier2Path.addLineToPoint(CGPointMake(19.8, 12.05))
        bezier2Path.addLineToPoint(CGPointMake(19.8, 12.05))
        bezier2Path.addLineToPoint(CGPointMake(17.56, 11.53))
        bezier2Path.addLineToPoint(CGPointMake(17.56, 7.41))
        bezier2Path.addCurveToPoint(CGPointMake(15.36, 5.24), controlPoint1: CGPointMake(17.56, 6.2), controlPoint2: CGPointMake(16.59, 5.24))
        bezier2Path.addLineToPoint(CGPointMake(13.16, 5.24))
        bezier2Path.addLineToPoint(CGPointMake(13.16, 2.64))
        bezier2Path.addLineToPoint(CGPointMake(8.76, 2.64))
        bezier2Path.addLineToPoint(CGPointMake(8.76, 5.24))
        bezier2Path.addLineToPoint(CGPointMake(6.56, 5.24))
        bezier2Path.addCurveToPoint(CGPointMake(4.36, 7.41), controlPoint1: CGPointMake(5.32, 5.24), controlPoint2: CGPointMake(4.36, 6.2))
        bezier2Path.addLineToPoint(CGPointMake(4.36, 11.53))
        bezier2Path.addLineToPoint(CGPointMake(1.98, 12.09))
        bezier2Path.addLineToPoint(CGPointMake(1.58, 12.18))
        bezier2Path.addCurveToPoint(CGPointMake(1.28, 12.7), controlPoint1: CGPointMake(1.36, 12.22), controlPoint2: CGPointMake(1.19, 12.48))
        bezier2Path.addCurveToPoint(CGPointMake(1.8, 13), controlPoint1: CGPointMake(1.32, 12.91), controlPoint2: CGPointMake(1.58, 13.09))
        bezier2Path.addLineToPoint(CGPointMake(2.2, 12.91))
        bezier2Path.addLineToPoint(CGPointMake(4.4, 22.14))
        bezier2Path.addCurveToPoint(CGPointMake(2.64, 24.27), controlPoint1: CGPointMake(3.39, 22.36), controlPoint2: CGPointMake(2.64, 23.23))
        bezier2Path.addCurveToPoint(CGPointMake(1.76, 25.13), controlPoint1: CGPointMake(2.64, 24.74), controlPoint2: CGPointMake(2.24, 25.13))
        bezier2Path.addCurveToPoint(CGPointMake(0.88, 24.27), controlPoint1: CGPointMake(1.28, 25.13), controlPoint2: CGPointMake(0.88, 24.74))
        bezier2Path.addCurveToPoint(CGPointMake(0.44, 23.83), controlPoint1: CGPointMake(0.88, 24.01), controlPoint2: CGPointMake(0.7, 23.83))
        bezier2Path.addCurveToPoint(CGPointMake(0, 24.27), controlPoint1: CGPointMake(0.18, 23.83), controlPoint2: CGPointMake(0, 24.01))
        bezier2Path.addCurveToPoint(CGPointMake(1.76, 26), controlPoint1: CGPointMake(0, 25.22), controlPoint2: CGPointMake(0.79, 26))
        bezier2Path.addCurveToPoint(CGPointMake(3.52, 24.27), controlPoint1: CGPointMake(2.73, 26), controlPoint2: CGPointMake(3.52, 25.22))
        bezier2Path.addCurveToPoint(CGPointMake(4.84, 22.97), controlPoint1: CGPointMake(3.52, 23.53), controlPoint2: CGPointMake(4.09, 22.97))
        bezier2Path.addCurveToPoint(CGPointMake(6.16, 24.27), controlPoint1: CGPointMake(5.59, 22.97), controlPoint2: CGPointMake(6.16, 23.53))
        bezier2Path.addCurveToPoint(CGPointMake(7.92, 26), controlPoint1: CGPointMake(6.16, 25.22), controlPoint2: CGPointMake(6.95, 26))
        bezier2Path.addCurveToPoint(CGPointMake(9.68, 24.27), controlPoint1: CGPointMake(8.89, 26), controlPoint2: CGPointMake(9.68, 25.22))
        bezier2Path.addCurveToPoint(CGPointMake(11, 22.97), controlPoint1: CGPointMake(9.68, 23.53), controlPoint2: CGPointMake(10.25, 22.97))
        bezier2Path.addCurveToPoint(CGPointMake(12.32, 24.27), controlPoint1: CGPointMake(11.75, 22.97), controlPoint2: CGPointMake(12.32, 23.53))
        bezier2Path.addCurveToPoint(CGPointMake(14.08, 26), controlPoint1: CGPointMake(12.32, 25.22), controlPoint2: CGPointMake(13.11, 26))
        bezier2Path.addCurveToPoint(CGPointMake(15.84, 24.27), controlPoint1: CGPointMake(15.05, 26), controlPoint2: CGPointMake(15.84, 25.22))
        bezier2Path.addCurveToPoint(CGPointMake(17.16, 22.97), controlPoint1: CGPointMake(15.84, 23.53), controlPoint2: CGPointMake(16.41, 22.97))
        bezier2Path.addCurveToPoint(CGPointMake(18.48, 24.27), controlPoint1: CGPointMake(17.91, 22.97), controlPoint2: CGPointMake(18.48, 23.53))
        bezier2Path.addCurveToPoint(CGPointMake(20.24, 26), controlPoint1: CGPointMake(18.48, 25.22), controlPoint2: CGPointMake(19.27, 26))
        bezier2Path.addCurveToPoint(CGPointMake(22, 24.27), controlPoint1: CGPointMake(21.21, 26), controlPoint2: CGPointMake(22, 25.22))
        bezier2Path.addCurveToPoint(CGPointMake(21.56, 23.83), controlPoint1: CGPointMake(22, 24.05), controlPoint2: CGPointMake(21.78, 23.83))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(7.92, 25.13))
        bezier2Path.addLineToPoint(CGPointMake(7.92, 25.13))
        bezier2Path.addCurveToPoint(CGPointMake(8.1, 25.13), controlPoint1: CGPointMake(7.96, 25.13), controlPoint2: CGPointMake(8.05, 25.13))
        bezier2Path.addCurveToPoint(CGPointMake(7.92, 25.13), controlPoint1: CGPointMake(8.05, 25.13), controlPoint2: CGPointMake(7.96, 25.13))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(14.08, 25.13))
        bezier2Path.addLineToPoint(CGPointMake(14.08, 25.13))
        bezier2Path.addCurveToPoint(CGPointMake(14.26, 25.13), controlPoint1: CGPointMake(14.12, 25.13), controlPoint2: CGPointMake(14.21, 25.13))
        bezier2Path.addCurveToPoint(CGPointMake(14.08, 25.13), controlPoint1: CGPointMake(14.21, 25.13), controlPoint2: CGPointMake(14.12, 25.13))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(11.4, 14.04))
        bezier2Path.addLineToPoint(CGPointMake(11.4, 21.67))
        bezier2Path.addCurveToPoint(CGPointMake(10.96, 22.1), controlPoint1: CGPointMake(11.4, 21.93), controlPoint2: CGPointMake(11.22, 22.1))
        bezier2Path.addCurveToPoint(CGPointMake(10.52, 21.67), controlPoint1: CGPointMake(10.69, 22.1), controlPoint2: CGPointMake(10.52, 21.93))
        bezier2Path.addLineToPoint(CGPointMake(10.52, 14.04))
        bezier2Path.addLineToPoint(CGPointMake(3.48, 16.16))
        bezier2Path.addCurveToPoint(CGPointMake(2.95, 15.86), controlPoint1: CGPointMake(3.26, 16.25), controlPoint2: CGPointMake(2.99, 16.12))
        bezier2Path.addCurveToPoint(CGPointMake(3.26, 15.34), controlPoint1: CGPointMake(2.86, 15.64), controlPoint2: CGPointMake(2.99, 15.38))
        bezier2Path.addLineToPoint(CGPointMake(10.52, 13.13))
        bezier2Path.addLineToPoint(CGPointMake(10.52, 10.05))
        bezier2Path.addLineToPoint(CGPointMake(5.24, 11.31))
        bezier2Path.addLineToPoint(CGPointMake(5.24, 7.37))
        bezier2Path.addCurveToPoint(CGPointMake(6.56, 6.07), controlPoint1: CGPointMake(5.24, 6.63), controlPoint2: CGPointMake(5.81, 6.07))
        bezier2Path.addLineToPoint(CGPointMake(15.36, 6.07))
        bezier2Path.addCurveToPoint(CGPointMake(16.68, 7.37), controlPoint1: CGPointMake(16.1, 6.07), controlPoint2: CGPointMake(16.68, 6.63))
        bezier2Path.addLineToPoint(CGPointMake(16.68, 11.31))
        bezier2Path.addLineToPoint(CGPointMake(11.4, 10.05))
        bezier2Path.addLineToPoint(CGPointMake(11.4, 13.13))
        bezier2Path.addLineToPoint(CGPointMake(18.48, 15.34))
        bezier2Path.addCurveToPoint(CGPointMake(18.79, 15.9), controlPoint1: CGPointMake(18.7, 15.43), controlPoint2: CGPointMake(18.83, 15.64))
        bezier2Path.addCurveToPoint(CGPointMake(18.35, 16.21), controlPoint1: CGPointMake(18.74, 16.08), controlPoint2: CGPointMake(18.57, 16.21))
        bezier2Path.addCurveToPoint(CGPointMake(18.22, 16.21), controlPoint1: CGPointMake(18.3, 16.21), controlPoint2: CGPointMake(18.26, 16.21))
        bezier2Path.addLineToPoint(CGPointMake(11.4, 14.04))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(14.48, 8.23))
        bezier4Path.addCurveToPoint(CGPointMake(14.04, 7.8), controlPoint1: CGPointMake(14.48, 7.97), controlPoint2: CGPointMake(14.3, 7.8))
        bezier4Path.addLineToPoint(CGPointMake(7.88, 7.8))
        bezier4Path.addCurveToPoint(CGPointMake(7.44, 8.23), controlPoint1: CGPointMake(7.61, 7.8), controlPoint2: CGPointMake(7.44, 7.97))
        bezier4Path.addCurveToPoint(CGPointMake(7.88, 8.67), controlPoint1: CGPointMake(7.44, 8.49), controlPoint2: CGPointMake(7.61, 8.67))
        bezier4Path.addLineToPoint(CGPointMake(14.04, 8.67))
        bezier4Path.addCurveToPoint(CGPointMake(14.48, 8.23), controlPoint1: CGPointMake(14.3, 8.67), controlPoint2: CGPointMake(14.48, 8.49))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(13.16, 0.43))
        bezier6Path.addCurveToPoint(CGPointMake(12.72, 0), controlPoint1: CGPointMake(13.16, 0.17), controlPoint2: CGPointMake(12.98, 0))
        bezier6Path.addLineToPoint(CGPointMake(9.2, 0))
        bezier6Path.addCurveToPoint(CGPointMake(8.76, 0.43), controlPoint1: CGPointMake(8.93, 0), controlPoint2: CGPointMake(8.76, 0.17))
        bezier6Path.addLineToPoint(CGPointMake(8.76, 1.73))
        bezier6Path.addLineToPoint(CGPointMake(13.16, 1.73))
        bezier6Path.addLineToPoint(CGPointMake(13.16, 0.43))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}

