//  BNIcon_EducationMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_EducationMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(18.81, 20.37))
        bezier2Path.addCurveToPoint(CGPointMake(18.5, 20.43), controlPoint1: CGPointMake(18.75, 20.43), controlPoint2: CGPointMake(18.62, 20.43))
        bezier2Path.addCurveToPoint(CGPointMake(18.19, 20.37), controlPoint1: CGPointMake(18.38, 20.43), controlPoint2: CGPointMake(18.32, 20.43))
        bezier2Path.addLineToPoint(CGPointMake(8.63, 15.59))
        bezier2Path.addLineToPoint(CGPointMake(8.63, 18.34))
        bezier2Path.addCurveToPoint(CGPointMake(11.1, 22.11), controlPoint1: CGPointMake(10.11, 19), controlPoint2: CGPointMake(11.1, 20.49))
        bezier2Path.addCurveToPoint(CGPointMake(11.1, 22.47), controlPoint1: CGPointMake(11.1, 22.23), controlPoint2: CGPointMake(11.1, 22.35))
        bezier2Path.addCurveToPoint(CGPointMake(18.5, 24.2), controlPoint1: CGPointMake(13.07, 23.54), controlPoint2: CGPointMake(15.6, 24.2))
        bezier2Path.addCurveToPoint(CGPointMake(30.83, 16.13), controlPoint1: CGPointMake(26.15, 24.2), controlPoint2: CGPointMake(30.83, 19.48))
        bezier2Path.addLineToPoint(CGPointMake(30.83, 14.33))
        bezier2Path.addLineToPoint(CGPointMake(18.81, 20.37))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(37, 9.55))
        bezier4Path.addCurveToPoint(CGPointMake(36.69, 9.01), controlPoint1: CGPointMake(37, 9.31), controlPoint2: CGPointMake(36.88, 9.13))
        bezier4Path.addLineToPoint(CGPointMake(18.81, 0.04))
        bezier4Path.addCurveToPoint(CGPointMake(18.25, 0.04), controlPoint1: CGPointMake(18.62, -0.01), controlPoint2: CGPointMake(18.44, -0.01))
        bezier4Path.addLineToPoint(CGPointMake(0.37, 9.01))
        bezier4Path.addCurveToPoint(CGPointMake(0, 9.55), controlPoint1: CGPointMake(0.12, 9.13), controlPoint2: CGPointMake(0, 9.31))
        bezier4Path.addCurveToPoint(CGPointMake(0.31, 10.09), controlPoint1: CGPointMake(0, 9.79), controlPoint2: CGPointMake(0.12, 9.97))
        bezier4Path.addLineToPoint(CGPointMake(18.5, 19.18))
        bezier4Path.addLineToPoint(CGPointMake(36.69, 10.09))
        bezier4Path.addCurveToPoint(CGPointMake(37, 9.55), controlPoint1: CGPointMake(36.88, 9.97), controlPoint2: CGPointMake(37, 9.79))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(7.4, 18.64))
        bezier6Path.addLineToPoint(CGPointMake(7.4, 14.99))
        bezier6Path.addLineToPoint(CGPointMake(6.17, 14.39))
        bezier6Path.addLineToPoint(CGPointMake(6.17, 18.64))
        bezier6Path.addCurveToPoint(CGPointMake(3.33, 21.93), controlPoint1: CGPointMake(4.56, 18.88), controlPoint2: CGPointMake(3.33, 20.25))
        bezier6Path.addCurveToPoint(CGPointMake(6.78, 25.28), controlPoint1: CGPointMake(3.33, 23.78), controlPoint2: CGPointMake(4.87, 25.28))
        bezier6Path.addCurveToPoint(CGPointMake(10.24, 21.93), controlPoint1: CGPointMake(8.7, 25.28), controlPoint2: CGPointMake(10.24, 23.78))
        bezier6Path.addCurveToPoint(CGPointMake(7.4, 18.64), controlPoint1: CGPointMake(10.18, 20.25), controlPoint2: CGPointMake(8.94, 18.94))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        CGContextRestoreGState(context)
    }
}
