//  BNIcon_FoodMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_FoodMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(23.45, 16.9))
        bezier2Path.addLineToPoint(CGPointMake(23.02, 16.9))
        bezier2Path.addLineToPoint(CGPointMake(13.03, 16.9))
        bezier2Path.addLineToPoint(CGPointMake(2.61, 16.9))
        bezier2Path.addCurveToPoint(CGPointMake(0, 19.28), controlPoint1: CGPointMake(1.13, 16.9), controlPoint2: CGPointMake(0, 17.94))
        bezier2Path.addCurveToPoint(CGPointMake(2.61, 21.67), controlPoint1: CGPointMake(0, 20.63), controlPoint2: CGPointMake(1.13, 21.67))
        bezier2Path.addLineToPoint(CGPointMake(23.45, 21.67))
        bezier2Path.addCurveToPoint(CGPointMake(26.06, 19.28), controlPoint1: CGPointMake(24.93, 21.67), controlPoint2: CGPointMake(26.06, 20.63))
        bezier2Path.addCurveToPoint(CGPointMake(23.45, 16.9), controlPoint1: CGPointMake(26.06, 17.94), controlPoint2: CGPointMake(24.93, 16.9))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(19.46, 20.28))
        bezier2Path.addLineToPoint(CGPointMake(14.77, 17.77))
        bezier2Path.addLineToPoint(CGPointMake(21.97, 17.77))
        bezier2Path.addLineToPoint(CGPointMake(19.46, 20.28))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(23.45, 22.1))
        bezier4Path.addLineToPoint(CGPointMake(2.61, 22.1))
        bezier4Path.addCurveToPoint(CGPointMake(2.17, 22.53), controlPoint1: CGPointMake(2.35, 22.1), controlPoint2: CGPointMake(2.17, 22.27))
        bezier4Path.addLineToPoint(CGPointMake(2.17, 23.66))
        bezier4Path.addCurveToPoint(CGPointMake(4.78, 26), controlPoint1: CGPointMake(2.17, 24.96), controlPoint2: CGPointMake(3.3, 26))
        bezier4Path.addLineToPoint(CGPointMake(21.28, 26))
        bezier4Path.addCurveToPoint(CGPointMake(23.89, 23.66), controlPoint1: CGPointMake(22.76, 26), controlPoint2: CGPointMake(23.89, 24.96))
        bezier4Path.addLineToPoint(CGPointMake(23.89, 22.53))
        bezier4Path.addCurveToPoint(CGPointMake(23.45, 22.1), controlPoint1: CGPointMake(23.89, 22.32), controlPoint2: CGPointMake(23.71, 22.1))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(25.36, 12.78))
        bezier6Path.addCurveToPoint(CGPointMake(26.1, 11.27), controlPoint1: CGPointMake(25.8, 12.57), controlPoint2: CGPointMake(26.1, 12.13))
        bezier6Path.addCurveToPoint(CGPointMake(23.71, 8.71), controlPoint1: CGPointMake(26.1, 10.23), controlPoint2: CGPointMake(24.28, 9.06))
        bezier6Path.addCurveToPoint(CGPointMake(23.49, 8.67), controlPoint1: CGPointMake(23.62, 8.67), controlPoint2: CGPointMake(23.58, 8.67))
        bezier6Path.addLineToPoint(CGPointMake(2.65, 8.67))
        bezier6Path.addCurveToPoint(CGPointMake(2.43, 8.71), controlPoint1: CGPointMake(2.56, 8.67), controlPoint2: CGPointMake(2.48, 8.67))
        bezier6Path.addCurveToPoint(CGPointMake(0.04, 11.27), controlPoint1: CGPointMake(1.87, 9.06), controlPoint2: CGPointMake(0.04, 10.23))
        bezier6Path.addCurveToPoint(CGPointMake(0.87, 12.74), controlPoint1: CGPointMake(0.04, 12.05), controlPoint2: CGPointMake(0.39, 12.48))
        bezier6Path.addCurveToPoint(CGPointMake(0.04, 14.3), controlPoint1: CGPointMake(0.39, 13.13), controlPoint2: CGPointMake(0.04, 13.69))
        bezier6Path.addCurveToPoint(CGPointMake(2.65, 16.47), controlPoint1: CGPointMake(0.04, 15.51), controlPoint2: CGPointMake(1.17, 16.47))
        bezier6Path.addLineToPoint(CGPointMake(23.49, 16.47))
        bezier6Path.addCurveToPoint(CGPointMake(26.1, 14.3), controlPoint1: CGPointMake(24.97, 16.47), controlPoint2: CGPointMake(26.1, 15.51))
        bezier6Path.addCurveToPoint(CGPointMake(25.36, 12.78), controlPoint1: CGPointMake(26.06, 13.74), controlPoint2: CGPointMake(25.8, 13.17))
        bezier6Path.closePath()
        bezier6Path.moveToPoint(CGPointMake(23.89, 12.13))
        bezier6Path.addCurveToPoint(CGPointMake(22.45, 11.83), controlPoint1: CGPointMake(22.97, 12.13), controlPoint2: CGPointMake(22.58, 11.96))
        bezier6Path.addCurveToPoint(CGPointMake(22.1, 11.7), controlPoint1: CGPointMake(22.37, 11.74), controlPoint2: CGPointMake(22.23, 11.7))
        bezier6Path.addCurveToPoint(CGPointMake(21.8, 11.92), controlPoint1: CGPointMake(21.97, 11.7), controlPoint2: CGPointMake(21.84, 11.79))
        bezier6Path.addCurveToPoint(CGPointMake(19.15, 13.43), controlPoint1: CGPointMake(21.32, 12.83), controlPoint2: CGPointMake(20.19, 13.43))
        bezier6Path.addCurveToPoint(CGPointMake(16.5, 11.53), controlPoint1: CGPointMake(17.89, 13.43), controlPoint2: CGPointMake(16.89, 12.44))
        bezier6Path.addCurveToPoint(CGPointMake(16.11, 11.27), controlPoint1: CGPointMake(16.42, 11.35), controlPoint2: CGPointMake(16.29, 11.27))
        bezier6Path.addLineToPoint(CGPointMake(16.11, 11.27))
        bezier6Path.addCurveToPoint(CGPointMake(15.72, 11.53), controlPoint1: CGPointMake(15.94, 11.27), controlPoint2: CGPointMake(15.76, 11.35))
        bezier6Path.addCurveToPoint(CGPointMake(13.07, 13), controlPoint1: CGPointMake(15.33, 12.48), controlPoint2: CGPointMake(14.33, 13))
        bezier6Path.addCurveToPoint(CGPointMake(10.42, 11.53), controlPoint1: CGPointMake(11.81, 13), controlPoint2: CGPointMake(10.86, 12.48))
        bezier6Path.addCurveToPoint(CGPointMake(10.03, 11.27), controlPoint1: CGPointMake(10.34, 11.35), controlPoint2: CGPointMake(10.21, 11.27))
        bezier6Path.addLineToPoint(CGPointMake(10.03, 11.27))
        bezier6Path.addCurveToPoint(CGPointMake(9.64, 11.53), controlPoint1: CGPointMake(9.86, 11.27), controlPoint2: CGPointMake(9.68, 11.35))
        bezier6Path.addCurveToPoint(CGPointMake(6.99, 13.43), controlPoint1: CGPointMake(9.25, 12.44), controlPoint2: CGPointMake(8.25, 13.43))
        bezier6Path.addCurveToPoint(CGPointMake(4.78, 11.92), controlPoint1: CGPointMake(6.04, 13.43), controlPoint2: CGPointMake(5.34, 12.96))
        bezier6Path.addCurveToPoint(CGPointMake(4.47, 11.7), controlPoint1: CGPointMake(4.73, 11.79), controlPoint2: CGPointMake(4.6, 11.7))
        bezier6Path.addCurveToPoint(CGPointMake(4.13, 11.83), controlPoint1: CGPointMake(4.34, 11.7), controlPoint2: CGPointMake(4.21, 11.74))
        bezier6Path.addCurveToPoint(CGPointMake(2.69, 12.13), controlPoint1: CGPointMake(4, 11.96), controlPoint2: CGPointMake(3.6, 12.13))
        bezier6Path.addCurveToPoint(CGPointMake(0.96, 11.27), controlPoint1: CGPointMake(1.22, 12.13), controlPoint2: CGPointMake(0.96, 11.92))
        bezier6Path.addCurveToPoint(CGPointMake(2.82, 9.53), controlPoint1: CGPointMake(0.96, 10.92), controlPoint2: CGPointMake(1.91, 10.1))
        bezier6Path.addLineToPoint(CGPointMake(23.41, 9.53))
        bezier6Path.addCurveToPoint(CGPointMake(25.27, 11.27), controlPoint1: CGPointMake(24.32, 10.1), controlPoint2: CGPointMake(25.27, 10.92))
        bezier6Path.addCurveToPoint(CGPointMake(23.89, 12.13), controlPoint1: CGPointMake(25.19, 12.05), controlPoint2: CGPointMake(25.14, 12.13))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(2.61, 8.23))
        bezier8Path.addLineToPoint(CGPointMake(23.45, 8.23))
        bezier8Path.addCurveToPoint(CGPointMake(23.89, 7.8), controlPoint1: CGPointMake(23.71, 8.23), controlPoint2: CGPointMake(23.89, 8.06))
        bezier8Path.addCurveToPoint(CGPointMake(13.03, 0), controlPoint1: CGPointMake(23.89, 2.04), controlPoint2: CGPointMake(18.02, 0))
        bezier8Path.addCurveToPoint(CGPointMake(2.17, 7.8), controlPoint1: CGPointMake(8.03, 0), controlPoint2: CGPointMake(2.17, 2.04))
        bezier8Path.addCurveToPoint(CGPointMake(2.61, 8.23), controlPoint1: CGPointMake(2.17, 8.06), controlPoint2: CGPointMake(2.39, 8.23))
        bezier8Path.closePath()
        bezier8Path.moveToPoint(CGPointMake(18.67, 4.33))
        bezier8Path.addCurveToPoint(CGPointMake(19.11, 4.77), controlPoint1: CGPointMake(18.93, 4.33), controlPoint2: CGPointMake(19.11, 4.51))
        bezier8Path.addCurveToPoint(CGPointMake(18.67, 5.2), controlPoint1: CGPointMake(19.11, 5.03), controlPoint2: CGPointMake(18.93, 5.2))
        bezier8Path.addCurveToPoint(CGPointMake(18.24, 4.77), controlPoint1: CGPointMake(18.41, 5.2), controlPoint2: CGPointMake(18.24, 5.03))
        bezier8Path.addCurveToPoint(CGPointMake(18.67, 4.33), controlPoint1: CGPointMake(18.24, 4.55), controlPoint2: CGPointMake(18.46, 4.33))
        bezier8Path.closePath()
        bezier8Path.moveToPoint(CGPointMake(16.07, 2.6))
        bezier8Path.addCurveToPoint(CGPointMake(16.5, 3.03), controlPoint1: CGPointMake(16.33, 2.6), controlPoint2: CGPointMake(16.5, 2.77))
        bezier8Path.addCurveToPoint(CGPointMake(16.07, 3.47), controlPoint1: CGPointMake(16.5, 3.29), controlPoint2: CGPointMake(16.33, 3.47))
        bezier8Path.addCurveToPoint(CGPointMake(15.63, 3.03), controlPoint1: CGPointMake(15.81, 3.47), controlPoint2: CGPointMake(15.63, 3.29))
        bezier8Path.addCurveToPoint(CGPointMake(16.07, 2.6), controlPoint1: CGPointMake(15.63, 2.82), controlPoint2: CGPointMake(15.85, 2.6))
        bezier8Path.closePath()
        bezier8Path.moveToPoint(CGPointMake(13.46, 4.33))
        bezier8Path.addCurveToPoint(CGPointMake(13.9, 4.77), controlPoint1: CGPointMake(13.72, 4.33), controlPoint2: CGPointMake(13.9, 4.51))
        bezier8Path.addCurveToPoint(CGPointMake(13.46, 5.2), controlPoint1: CGPointMake(13.9, 5.03), controlPoint2: CGPointMake(13.72, 5.2))
        bezier8Path.addCurveToPoint(CGPointMake(13.03, 4.77), controlPoint1: CGPointMake(13.2, 5.2), controlPoint2: CGPointMake(13.03, 5.03))
        bezier8Path.addCurveToPoint(CGPointMake(13.46, 4.33), controlPoint1: CGPointMake(13.03, 4.55), controlPoint2: CGPointMake(13.25, 4.33))
        bezier8Path.closePath()
        bezier8Path.moveToPoint(CGPointMake(9.99, 2.6))
        bezier8Path.addCurveToPoint(CGPointMake(10.42, 3.03), controlPoint1: CGPointMake(10.25, 2.6), controlPoint2: CGPointMake(10.42, 2.77))
        bezier8Path.addCurveToPoint(CGPointMake(9.99, 3.47), controlPoint1: CGPointMake(10.42, 3.29), controlPoint2: CGPointMake(10.25, 3.47))
        bezier8Path.addCurveToPoint(CGPointMake(9.55, 3.03), controlPoint1: CGPointMake(9.73, 3.47), controlPoint2: CGPointMake(9.55, 3.29))
        bezier8Path.addCurveToPoint(CGPointMake(9.99, 2.6), controlPoint1: CGPointMake(9.55, 2.82), controlPoint2: CGPointMake(9.77, 2.6))
        bezier8Path.closePath()
        bezier8Path.moveToPoint(CGPointMake(7.38, 4.33))
        bezier8Path.addCurveToPoint(CGPointMake(7.82, 4.77), controlPoint1: CGPointMake(7.64, 4.33), controlPoint2: CGPointMake(7.82, 4.51))
        bezier8Path.addCurveToPoint(CGPointMake(7.38, 5.2), controlPoint1: CGPointMake(7.82, 5.03), controlPoint2: CGPointMake(7.64, 5.2))
        bezier8Path.addCurveToPoint(CGPointMake(6.95, 4.77), controlPoint1: CGPointMake(7.12, 5.2), controlPoint2: CGPointMake(6.95, 5.03))
        bezier8Path.addCurveToPoint(CGPointMake(7.38, 4.33), controlPoint1: CGPointMake(6.95, 4.55), controlPoint2: CGPointMake(7.17, 4.33))
        bezier8Path.closePath()
        bezier8Path.miterLimit = 4;
        
        color!.setFill()
        bezier8Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}
