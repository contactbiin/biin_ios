//  BNIcon_PhoneMedium.swift
//  biin
//  Created by Esteban Padilla on 2/28/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_PhoneMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(17.96, 17.68))
        bezier2Path.addCurveToPoint(CGPointMake(16.17, 16.89), controlPoint1: CGPointMake(17.5, 17.2), controlPoint2: CGPointMake(16.83, 16.89))
        bezier2Path.addCurveToPoint(CGPointMake(14.37, 17.68), controlPoint1: CGPointMake(15.5, 16.89), controlPoint2: CGPointMake(14.87, 17.15))
        bezier2Path.addLineToPoint(CGPointMake(13.91, 18.15))
        bezier2Path.addCurveToPoint(CGPointMake(7.65, 11.64), controlPoint1: CGPointMake(11.65, 16.2), controlPoint2: CGPointMake(9.52, 13.98))
        bezier2Path.addLineToPoint(CGPointMake(8.1, 11.16))
        bezier2Path.addCurveToPoint(CGPointMake(8.1, 7.47), controlPoint1: CGPointMake(9.11, 10.12), controlPoint2: CGPointMake(9.11, 8.47))
        bezier2Path.addLineToPoint(CGPointMake(5.85, 5.17))
        bezier2Path.addCurveToPoint(CGPointMake(4.05, 4.39), controlPoint1: CGPointMake(5.39, 4.69), controlPoint2: CGPointMake(4.72, 4.39))
        bezier2Path.addCurveToPoint(CGPointMake(2.26, 5.17), controlPoint1: CGPointMake(3.38, 4.39), controlPoint2: CGPointMake(2.76, 4.65))
        bezier2Path.addLineToPoint(CGPointMake(1.05, 6.43))
        bezier2Path.addCurveToPoint(CGPointMake(0.59, 11.12), controlPoint1: CGPointMake(-0.17, 7.69), controlPoint2: CGPointMake(-0.33, 9.64))
        bezier2Path.addCurveToPoint(CGPointMake(14.41, 25.49), controlPoint1: CGPointMake(4.18, 16.76), controlPoint2: CGPointMake(8.94, 21.76))
        bezier2Path.addCurveToPoint(CGPointMake(16.37, 26.1), controlPoint1: CGPointMake(15, 25.88), controlPoint2: CGPointMake(15.66, 26.1))
        bezier2Path.addCurveToPoint(CGPointMake(18.88, 25.01), controlPoint1: CGPointMake(17.34, 26.1), controlPoint2: CGPointMake(18.21, 25.71))
        bezier2Path.addLineToPoint(CGPointMake(20.09, 23.75))
        bezier2Path.addCurveToPoint(CGPointMake(20.09, 20.06), controlPoint1: CGPointMake(21.09, 22.71), controlPoint2: CGPointMake(21.09, 21.06))
        bezier2Path.addLineToPoint(CGPointMake(17.96, 17.68))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(12.57, 0))
        bezier4Path.addCurveToPoint(CGPointMake(12.16, 0.43), controlPoint1: CGPointMake(12.32, 0), controlPoint2: CGPointMake(12.16, 0.17))
        bezier4Path.addCurveToPoint(CGPointMake(12.57, 0.87), controlPoint1: CGPointMake(12.16, 0.69), controlPoint2: CGPointMake(12.32, 0.87))
        bezier4Path.addCurveToPoint(CGPointMake(24.27, 13.03), controlPoint1: CGPointMake(19.01, 0.87), controlPoint2: CGPointMake(24.27, 6.34))
        bezier4Path.addCurveToPoint(CGPointMake(24.69, 13.46), controlPoint1: CGPointMake(24.27, 13.29), controlPoint2: CGPointMake(24.44, 13.46))
        bezier4Path.addCurveToPoint(CGPointMake(25.1, 13.03), controlPoint1: CGPointMake(24.94, 13.46), controlPoint2: CGPointMake(25.1, 13.29))
        bezier4Path.addCurveToPoint(CGPointMake(12.57, 0), controlPoint1: CGPointMake(25.1, 5.86), controlPoint2: CGPointMake(19.47, 0))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(12.57, 5.25))
        bezier6Path.addCurveToPoint(CGPointMake(20.05, 13.03), controlPoint1: CGPointMake(16.71, 5.25), controlPoint2: CGPointMake(20.05, 8.73))
        bezier6Path.addCurveToPoint(CGPointMake(20.47, 13.46), controlPoint1: CGPointMake(20.05, 13.29), controlPoint2: CGPointMake(20.22, 13.46))
        bezier6Path.addCurveToPoint(CGPointMake(20.89, 13.03), controlPoint1: CGPointMake(20.72, 13.46), controlPoint2: CGPointMake(20.89, 13.29))
        bezier6Path.addCurveToPoint(CGPointMake(12.57, 4.39), controlPoint1: CGPointMake(20.89, 8.25), controlPoint2: CGPointMake(17.17, 4.39))
        bezier6Path.addCurveToPoint(CGPointMake(12.16, 4.82), controlPoint1: CGPointMake(12.32, 4.39), controlPoint2: CGPointMake(12.16, 4.56))
        bezier6Path.addCurveToPoint(CGPointMake(12.57, 5.25), controlPoint1: CGPointMake(12.16, 5.08), controlPoint2: CGPointMake(12.32, 5.25))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(12.57, 9.64))
        bezier8Path.addCurveToPoint(CGPointMake(15.83, 13.03), controlPoint1: CGPointMake(14.37, 9.64), controlPoint2: CGPointMake(15.83, 11.16))
        bezier8Path.addCurveToPoint(CGPointMake(16.25, 13.46), controlPoint1: CGPointMake(15.83, 13.29), controlPoint2: CGPointMake(16, 13.46))
        bezier8Path.addCurveToPoint(CGPointMake(16.67, 13.03), controlPoint1: CGPointMake(16.5, 13.46), controlPoint2: CGPointMake(16.67, 13.29))
        bezier8Path.addCurveToPoint(CGPointMake(12.57, 8.77), controlPoint1: CGPointMake(16.67, 10.68), controlPoint2: CGPointMake(14.83, 8.77))
        bezier8Path.addCurveToPoint(CGPointMake(12.16, 9.21), controlPoint1: CGPointMake(12.32, 8.77), controlPoint2: CGPointMake(12.16, 8.95))
        bezier8Path.addCurveToPoint(CGPointMake(12.57, 9.64), controlPoint1: CGPointMake(12.16, 9.47), controlPoint2: CGPointMake(12.32, 9.64))
        bezier8Path.closePath()
        bezier8Path.miterLimit = 4;
        
        color!.setFill()
        bezier8Path.fill()
        
        CGContextRestoreGState(context)
    }
}
