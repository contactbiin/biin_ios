//  BNIcon_CarsMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.


import Foundation
import QuartzCore
import UIKit

class BNIcon_CarsMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(35.4, 15))
        bezier2Path.addLineToPoint(CGPointMake(34.8, 15))
        bezier2Path.addLineToPoint(CGPointMake(34.8, 9.38))
        bezier2Path.addCurveToPoint(CGPointMake(31.8, 6.25), controlPoint1: CGPointMake(34.8, 7.69), controlPoint2: CGPointMake(33.42, 6.25))
        bezier2Path.addLineToPoint(CGPointMake(29.76, 6.25))
        bezier2Path.addLineToPoint(CGPointMake(26.94, 0.37))
        bezier2Path.addCurveToPoint(CGPointMake(26.4, 0), controlPoint1: CGPointMake(26.82, 0.12), controlPoint2: CGPointMake(26.64, 0))
        bezier2Path.addLineToPoint(CGPointMake(12.6, 0))
        bezier2Path.addCurveToPoint(CGPointMake(12.06, 0.31), controlPoint1: CGPointMake(12.36, 0), controlPoint2: CGPointMake(12.18, 0.13))
        bezier2Path.addLineToPoint(CGPointMake(8.64, 6.25))
        bezier2Path.addLineToPoint(CGPointMake(3, 6.25))
        bezier2Path.addCurveToPoint(CGPointMake(0, 9.38), controlPoint1: CGPointMake(1.38, 6.25), controlPoint2: CGPointMake(0, 7.69))
        bezier2Path.addLineToPoint(CGPointMake(0, 15.62))
        bezier2Path.addCurveToPoint(CGPointMake(0.6, 16.25), controlPoint1: CGPointMake(0, 16), controlPoint2: CGPointMake(0.24, 16.25))
        bezier2Path.addLineToPoint(CGPointMake(1.5, 16.25))
        bezier2Path.addCurveToPoint(CGPointMake(1.5, 15.94), controlPoint1: CGPointMake(1.5, 16.12), controlPoint2: CGPointMake(1.5, 16.06))
        bezier2Path.addCurveToPoint(CGPointMake(6.6, 10.62), controlPoint1: CGPointMake(1.5, 13), controlPoint2: CGPointMake(3.78, 10.62))
        bezier2Path.addCurveToPoint(CGPointMake(11.7, 15.94), controlPoint1: CGPointMake(9.42, 10.62), controlPoint2: CGPointMake(11.7, 13))
        bezier2Path.addCurveToPoint(CGPointMake(11.7, 16.25), controlPoint1: CGPointMake(11.7, 16.06), controlPoint2: CGPointMake(11.7, 16.12))
        bezier2Path.addLineToPoint(CGPointMake(22.56, 16.25))
        bezier2Path.addCurveToPoint(CGPointMake(22.56, 15.94), controlPoint1: CGPointMake(22.56, 16.12), controlPoint2: CGPointMake(22.56, 16.06))
        bezier2Path.addCurveToPoint(CGPointMake(27.66, 10.62), controlPoint1: CGPointMake(22.56, 13), controlPoint2: CGPointMake(24.84, 10.62))
        bezier2Path.addCurveToPoint(CGPointMake(32.76, 15.94), controlPoint1: CGPointMake(30.48, 10.62), controlPoint2: CGPointMake(32.76, 13))
        bezier2Path.addCurveToPoint(CGPointMake(32.76, 16.25), controlPoint1: CGPointMake(32.76, 16.06), controlPoint2: CGPointMake(32.76, 16.12))
        bezier2Path.addLineToPoint(CGPointMake(34.2, 16.25))
        bezier2Path.addLineToPoint(CGPointMake(35.4, 16.25))
        bezier2Path.addCurveToPoint(CGPointMake(36, 15.62), controlPoint1: CGPointMake(35.76, 16.25), controlPoint2: CGPointMake(36, 16))
        bezier2Path.addCurveToPoint(CGPointMake(35.4, 15), controlPoint1: CGPointMake(36, 15.25), controlPoint2: CGPointMake(35.76, 15))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(16.2, 3.75))
        bezier2Path.addLineToPoint(CGPointMake(14.76, 3.75))
        bezier2Path.addLineToPoint(CGPointMake(13.14, 7.12))
        bezier2Path.addCurveToPoint(CGPointMake(12.6, 7.5), controlPoint1: CGPointMake(13.02, 7.37), controlPoint2: CGPointMake(12.84, 7.5))
        bezier2Path.addCurveToPoint(CGPointMake(12.36, 7.44), controlPoint1: CGPointMake(12.48, 7.5), controlPoint2: CGPointMake(12.42, 7.5))
        bezier2Path.addCurveToPoint(CGPointMake(12.12, 6.62), controlPoint1: CGPointMake(12.06, 7.31), controlPoint2: CGPointMake(11.94, 6.94))
        bezier2Path.addLineToPoint(CGPointMake(13.92, 2.87))
        bezier2Path.addCurveToPoint(CGPointMake(14.46, 2.5), controlPoint1: CGPointMake(14.04, 2.69), controlPoint2: CGPointMake(14.22, 2.5))
        bezier2Path.addLineToPoint(CGPointMake(16.26, 2.5))
        bezier2Path.addCurveToPoint(CGPointMake(16.86, 3.12), controlPoint1: CGPointMake(16.62, 2.5), controlPoint2: CGPointMake(16.86, 2.75))
        bezier2Path.addCurveToPoint(CGPointMake(16.2, 3.75), controlPoint1: CGPointMake(16.86, 3.5), controlPoint2: CGPointMake(16.56, 3.75))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(27.6, 11.88))
        bezier4Path.addCurveToPoint(CGPointMake(23.7, 15.94), controlPoint1: CGPointMake(25.44, 11.88), controlPoint2: CGPointMake(23.7, 13.69))
        bezier4Path.addCurveToPoint(CGPointMake(27.6, 20), controlPoint1: CGPointMake(23.7, 18.19), controlPoint2: CGPointMake(25.44, 20))
        bezier4Path.addCurveToPoint(CGPointMake(31.5, 15.94), controlPoint1: CGPointMake(29.76, 20), controlPoint2: CGPointMake(31.5, 18.19))
        bezier4Path.addCurveToPoint(CGPointMake(27.6, 11.88), controlPoint1: CGPointMake(31.5, 13.69), controlPoint2: CGPointMake(29.76, 11.88))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(6.6, 11.88))
        bezier6Path.addCurveToPoint(CGPointMake(2.7, 15.94), controlPoint1: CGPointMake(4.44, 11.88), controlPoint2: CGPointMake(2.7, 13.69))
        bezier6Path.addCurveToPoint(CGPointMake(6.6, 20), controlPoint1: CGPointMake(2.7, 18.19), controlPoint2: CGPointMake(4.44, 20))
        bezier6Path.addCurveToPoint(CGPointMake(10.5, 15.94), controlPoint1: CGPointMake(8.76, 20), controlPoint2: CGPointMake(10.5, 18.19))
        bezier6Path.addCurveToPoint(CGPointMake(6.6, 11.88), controlPoint1: CGPointMake(10.5, 13.69), controlPoint2: CGPointMake(8.76, 11.88))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}

