//  BNIcon_BarMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_BarMedium:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        let context = UIGraphicsGetCurrentContext()
    
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(21.12, 21.67))
        bezier2Path.addLineToPoint(CGPointMake(4.74, 21.67))
        bezier2Path.addCurveToPoint(CGPointMake(2.59, 23.33), controlPoint1: CGPointMake(3.41, 21.67), controlPoint2: CGPointMake(2.59, 22.29))
        bezier2Path.addCurveToPoint(CGPointMake(4.74, 25), controlPoint1: CGPointMake(2.59, 24.38), controlPoint2: CGPointMake(3.41, 25))
        bezier2Path.addLineToPoint(CGPointMake(21.12, 25))
        bezier2Path.addCurveToPoint(CGPointMake(23.28, 23.33), controlPoint1: CGPointMake(22.46, 25), controlPoint2: CGPointMake(23.28, 24.38))
        bezier2Path.addCurveToPoint(CGPointMake(21.12, 21.67), controlPoint1: CGPointMake(23.28, 22.29), controlPoint2: CGPointMake(22.46, 21.67))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(22.33, 11.29))
        bezier4Path.addCurveToPoint(CGPointMake(25, 7.08), controlPoint1: CGPointMake(23.97, 10.62), controlPoint2: CGPointMake(25, 9.08))
        bezier4Path.addCurveToPoint(CGPointMake(20.26, 2.5), controlPoint1: CGPointMake(25, 4.33), controlPoint2: CGPointMake(23.1, 2.5))
        bezier4Path.addCurveToPoint(CGPointMake(18.28, 3.17), controlPoint1: CGPointMake(19.48, 2.5), controlPoint2: CGPointMake(18.84, 2.83))
        bezier4Path.addCurveToPoint(CGPointMake(12.93, 0), controlPoint1: CGPointMake(17.07, 1.08), controlPoint2: CGPointMake(15.26, 0))
        bezier4Path.addCurveToPoint(CGPointMake(7.16, 3.17), controlPoint1: CGPointMake(10.52, 0), controlPoint2: CGPointMake(8.36, 1.21))
        bezier4Path.addCurveToPoint(CGPointMake(5.17, 2.5), controlPoint1: CGPointMake(6.59, 2.83), controlPoint2: CGPointMake(5.95, 2.5))
        bezier4Path.addCurveToPoint(CGPointMake(0, 7.08), controlPoint1: CGPointMake(2.24, 2.5), controlPoint2: CGPointMake(0, 4.46))
        bezier4Path.addCurveToPoint(CGPointMake(5.09, 11.29), controlPoint1: CGPointMake(0, 9.58), controlPoint2: CGPointMake(2.24, 11.42))
        bezier4Path.addCurveToPoint(CGPointMake(5.47, 12.88), controlPoint1: CGPointMake(5.04, 11.83), controlPoint2: CGPointMake(5.22, 12.38))
        bezier4Path.addLineToPoint(CGPointMake(4.31, 20.38))
        bezier4Path.addCurveToPoint(CGPointMake(4.4, 20.71), controlPoint1: CGPointMake(4.31, 20.5), controlPoint2: CGPointMake(4.31, 20.62))
        bezier4Path.addCurveToPoint(CGPointMake(4.74, 20.83), controlPoint1: CGPointMake(4.48, 20.79), controlPoint2: CGPointMake(4.61, 20.83))
        bezier4Path.addLineToPoint(CGPointMake(20.26, 20.83))
        bezier4Path.addCurveToPoint(CGPointMake(20.56, 20.71), controlPoint1: CGPointMake(20.39, 20.83), controlPoint2: CGPointMake(20.52, 20.79))
        bezier4Path.addCurveToPoint(CGPointMake(20.69, 20.38), controlPoint1: CGPointMake(20.65, 20.62), controlPoint2: CGPointMake(20.69, 20.5))
        bezier4Path.addLineToPoint(CGPointMake(20.6, 19.58))
        bezier4Path.addLineToPoint(CGPointMake(21.98, 19.58))
        bezier4Path.addCurveToPoint(CGPointMake(24.14, 17.5), controlPoint1: CGPointMake(23.19, 19.58), controlPoint2: CGPointMake(24.14, 18.67))
        bezier4Path.addLineToPoint(CGPointMake(24.14, 13.33))
        bezier4Path.addCurveToPoint(CGPointMake(22.33, 11.29), controlPoint1: CGPointMake(24.14, 12.29), controlPoint2: CGPointMake(23.36, 11.46))
        bezier4Path.closePath()
        bezier4Path.moveToPoint(CGPointMake(9.48, 18.38))
        bezier4Path.addCurveToPoint(CGPointMake(9.05, 18.75), controlPoint1: CGPointMake(9.48, 18.58), controlPoint2: CGPointMake(9.27, 18.75))
        bezier4Path.addCurveToPoint(CGPointMake(9.01, 18.75), controlPoint1: CGPointMake(9.05, 18.75), controlPoint2: CGPointMake(9.05, 18.75))
        bezier4Path.addCurveToPoint(CGPointMake(8.62, 18.29), controlPoint1: CGPointMake(8.75, 18.75), controlPoint2: CGPointMake(8.58, 18.54))
        bezier4Path.addLineToPoint(CGPointMake(8.88, 14.54))
        bezier4Path.addCurveToPoint(CGPointMake(9.78, 14.21), controlPoint1: CGPointMake(9.18, 14.46), controlPoint2: CGPointMake(9.48, 14.38))
        bezier4Path.addLineToPoint(CGPointMake(9.48, 18.38))
        bezier4Path.closePath()
        bezier4Path.moveToPoint(CGPointMake(12.93, 18.33))
        bezier4Path.addCurveToPoint(CGPointMake(12.5, 18.75), controlPoint1: CGPointMake(12.93, 18.58), controlPoint2: CGPointMake(12.76, 18.75))
        bezier4Path.addCurveToPoint(CGPointMake(12.07, 18.33), controlPoint1: CGPointMake(12.24, 18.75), controlPoint2: CGPointMake(12.07, 18.58))
        bezier4Path.addLineToPoint(CGPointMake(12.07, 13.75))
        bezier4Path.addCurveToPoint(CGPointMake(12.5, 13.33), controlPoint1: CGPointMake(12.07, 13.5), controlPoint2: CGPointMake(12.24, 13.33))
        bezier4Path.addCurveToPoint(CGPointMake(12.93, 13.75), controlPoint1: CGPointMake(12.76, 13.33), controlPoint2: CGPointMake(12.93, 13.5))
        bezier4Path.addLineToPoint(CGPointMake(12.93, 18.33))
        bezier4Path.closePath()
        bezier4Path.moveToPoint(CGPointMake(16.42, 18.75))
        bezier4Path.addLineToPoint(CGPointMake(16.38, 18.75))
        bezier4Path.addCurveToPoint(CGPointMake(15.95, 18.38), controlPoint1: CGPointMake(16.16, 18.75), controlPoint2: CGPointMake(15.99, 18.58))
        bezier4Path.addLineToPoint(CGPointMake(15.43, 13.71))
        bezier4Path.addCurveToPoint(CGPointMake(15.82, 13.25), controlPoint1: CGPointMake(15.39, 13.5), controlPoint2: CGPointMake(15.56, 13.29))
        bezier4Path.addCurveToPoint(CGPointMake(16.29, 13.62), controlPoint1: CGPointMake(16.08, 13.21), controlPoint2: CGPointMake(16.25, 13.37))
        bezier4Path.addLineToPoint(CGPointMake(16.81, 18.29))
        bezier4Path.addCurveToPoint(CGPointMake(16.42, 18.75), controlPoint1: CGPointMake(16.85, 18.5), controlPoint2: CGPointMake(16.68, 18.71))
        bezier4Path.closePath()
        bezier4Path.moveToPoint(CGPointMake(16.81, 9.17))
        bezier4Path.addLineToPoint(CGPointMake(16.81, 9.17))
        bezier4Path.addCurveToPoint(CGPointMake(16.51, 9.29), controlPoint1: CGPointMake(16.68, 9.17), controlPoint2: CGPointMake(16.59, 9.21))
        bezier4Path.addCurveToPoint(CGPointMake(12.54, 11.08), controlPoint1: CGPointMake(15.39, 10.46), controlPoint2: CGPointMake(14.05, 11.08))
        bezier4Path.addCurveToPoint(CGPointMake(10.91, 10.83), controlPoint1: CGPointMake(12.03, 11.08), controlPoint2: CGPointMake(11.47, 11))
        bezier4Path.addCurveToPoint(CGPointMake(10.52, 10.92), controlPoint1: CGPointMake(10.78, 10.79), controlPoint2: CGPointMake(10.6, 10.83))
        bezier4Path.addCurveToPoint(CGPointMake(10.34, 11.29), controlPoint1: CGPointMake(10.39, 11), controlPoint2: CGPointMake(10.34, 11.12))
        bezier4Path.addCurveToPoint(CGPointMake(9.74, 13.17), controlPoint1: CGPointMake(10.39, 12), controlPoint2: CGPointMake(10.17, 12.67))
        bezier4Path.addCurveToPoint(CGPointMake(8.28, 13.79), controlPoint1: CGPointMake(9.35, 13.58), controlPoint2: CGPointMake(8.84, 13.79))
        bezier4Path.addCurveToPoint(CGPointMake(6.51, 12.96), controlPoint1: CGPointMake(7.63, 13.79), controlPoint2: CGPointMake(6.98, 13.5))
        bezier4Path.addCurveToPoint(CGPointMake(6.03, 10.96), controlPoint1: CGPointMake(6.03, 12.37), controlPoint2: CGPointMake(5.86, 11.62))
        bezier4Path.addCurveToPoint(CGPointMake(5.95, 10.58), controlPoint1: CGPointMake(6.08, 10.83), controlPoint2: CGPointMake(6.03, 10.67))
        bezier4Path.addCurveToPoint(CGPointMake(5.6, 10.42), controlPoint1: CGPointMake(5.82, 10.46), controlPoint2: CGPointMake(5.73, 10.42))
        bezier4Path.addLineToPoint(CGPointMake(5.56, 10.42))
        bezier4Path.addCurveToPoint(CGPointMake(4.83, 10.46), controlPoint1: CGPointMake(5.3, 10.46), controlPoint2: CGPointMake(5.09, 10.46))
        bezier4Path.addCurveToPoint(CGPointMake(0.86, 7.08), controlPoint1: CGPointMake(2.54, 10.46), controlPoint2: CGPointMake(0.86, 9.04))
        bezier4Path.addCurveToPoint(CGPointMake(5.17, 3.33), controlPoint1: CGPointMake(0.86, 4.92), controlPoint2: CGPointMake(2.67, 3.33))
        bezier4Path.addCurveToPoint(CGPointMake(6.94, 4), controlPoint1: CGPointMake(5.82, 3.33), controlPoint2: CGPointMake(6.34, 3.67))
        bezier4Path.addLineToPoint(CGPointMake(7.11, 4.08))
        bezier4Path.addCurveToPoint(CGPointMake(7.46, 4.17), controlPoint1: CGPointMake(7.2, 4.17), controlPoint2: CGPointMake(7.33, 4.17))
        bezier4Path.addCurveToPoint(CGPointMake(7.72, 3.96), controlPoint1: CGPointMake(7.59, 4.13), controlPoint2: CGPointMake(7.67, 4.04))
        bezier4Path.addCurveToPoint(CGPointMake(12.93, 0.83), controlPoint1: CGPointMake(8.71, 2.04), controlPoint2: CGPointMake(10.69, 0.83))
        bezier4Path.addCurveToPoint(CGPointMake(17.72, 3.92), controlPoint1: CGPointMake(15.04, 0.83), controlPoint2: CGPointMake(16.68, 1.88))
        bezier4Path.addCurveToPoint(CGPointMake(17.97, 4.13), controlPoint1: CGPointMake(17.76, 4.04), controlPoint2: CGPointMake(17.84, 4.08))
        bezier4Path.addCurveToPoint(CGPointMake(18.32, 4.08), controlPoint1: CGPointMake(18.1, 4.17), controlPoint2: CGPointMake(18.23, 4.13))
        bezier4Path.addLineToPoint(CGPointMake(18.49, 3.96))
        bezier4Path.addCurveToPoint(CGPointMake(20.26, 3.29), controlPoint1: CGPointMake(19.05, 3.62), controlPoint2: CGPointMake(19.61, 3.29))
        bezier4Path.addCurveToPoint(CGPointMake(24.14, 7.04), controlPoint1: CGPointMake(22.63, 3.29), controlPoint2: CGPointMake(24.14, 4.75))
        bezier4Path.addCurveToPoint(CGPointMake(20.26, 10.79), controlPoint1: CGPointMake(24.14, 9.33), controlPoint2: CGPointMake(22.63, 10.79))
        bezier4Path.addCurveToPoint(CGPointMake(17.11, 9.25), controlPoint1: CGPointMake(19.09, 10.79), controlPoint2: CGPointMake(17.84, 10))
        bezier4Path.addCurveToPoint(CGPointMake(16.81, 9.17), controlPoint1: CGPointMake(17.03, 9.21), controlPoint2: CGPointMake(16.94, 9.17))
        bezier4Path.closePath()
        bezier4Path.moveToPoint(CGPointMake(23.28, 17.5))
        bezier4Path.addCurveToPoint(CGPointMake(21.98, 18.75), controlPoint1: CGPointMake(23.28, 18.21), controlPoint2: CGPointMake(22.72, 18.75))
        bezier4Path.addLineToPoint(CGPointMake(20.52, 18.75))
        bezier4Path.addLineToPoint(CGPointMake(19.83, 12.08))
        bezier4Path.addLineToPoint(CGPointMake(21.98, 12.08))
        bezier4Path.addCurveToPoint(CGPointMake(23.28, 13.33), controlPoint1: CGPointMake(22.72, 12.08), controlPoint2: CGPointMake(23.28, 12.62))
        bezier4Path.addLineToPoint(CGPointMake(23.28, 17.5))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}

