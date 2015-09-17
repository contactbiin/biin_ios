//  BNIcon_PersonalCareMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_PersonalCareMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(6.6, 4.41))
        bezier2Path.addLineToPoint(CGPointMake(4.4, 4.41))
        bezier2Path.addCurveToPoint(CGPointMake(1.47, 7.35), controlPoint1: CGPointMake(3.01, 4.41), controlPoint2: CGPointMake(1.47, 5.96))
        bezier2Path.addLineToPoint(CGPointMake(1.47, 11.76))
        bezier2Path.addLineToPoint(CGPointMake(0.73, 11.76))
        bezier2Path.addCurveToPoint(CGPointMake(0, 12.5), controlPoint1: CGPointMake(0.29, 11.76), controlPoint2: CGPointMake(0, 12.06))
        bezier2Path.addCurveToPoint(CGPointMake(0.73, 13.24), controlPoint1: CGPointMake(0, 12.94), controlPoint2: CGPointMake(0.29, 13.24))
        bezier2Path.addLineToPoint(CGPointMake(1.47, 13.24))
        bezier2Path.addLineToPoint(CGPointMake(1.47, 17.65))
        bezier2Path.addCurveToPoint(CGPointMake(4.4, 20.59), controlPoint1: CGPointMake(1.47, 19.04), controlPoint2: CGPointMake(3.01, 20.59))
        bezier2Path.addLineToPoint(CGPointMake(6.6, 20.59))
        bezier2Path.addCurveToPoint(CGPointMake(7.33, 19.85), controlPoint1: CGPointMake(7.04, 20.59), controlPoint2: CGPointMake(7.33, 20.29))
        bezier2Path.addLineToPoint(CGPointMake(7.33, 5.15))
        bezier2Path.addCurveToPoint(CGPointMake(6.6, 4.41), controlPoint1: CGPointMake(7.33, 4.78), controlPoint2: CGPointMake(6.97, 4.41))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(32.27, 0))
        bezier4Path.addLineToPoint(CGPointMake(29.33, 0))
        bezier4Path.addCurveToPoint(CGPointMake(26.4, 2.94), controlPoint1: CGPointMake(27.5, 0), controlPoint2: CGPointMake(26.4, 1.1))
        bezier4Path.addLineToPoint(CGPointMake(26.4, 11.76))
        bezier4Path.addLineToPoint(CGPointMake(17.6, 11.76))
        bezier4Path.addLineToPoint(CGPointMake(17.6, 2.94))
        bezier4Path.addCurveToPoint(CGPointMake(14.67, 0), controlPoint1: CGPointMake(17.6, 1.1), controlPoint2: CGPointMake(16.5, 0))
        bezier4Path.addLineToPoint(CGPointMake(11.73, 0))
        bezier4Path.addCurveToPoint(CGPointMake(8.8, 2.94), controlPoint1: CGPointMake(9.9, 0), controlPoint2: CGPointMake(8.8, 1.1))
        bezier4Path.addLineToPoint(CGPointMake(8.8, 22.06))
        bezier4Path.addCurveToPoint(CGPointMake(11.73, 25), controlPoint1: CGPointMake(8.8, 23.9), controlPoint2: CGPointMake(9.9, 25))
        bezier4Path.addLineToPoint(CGPointMake(14.67, 25))
        bezier4Path.addCurveToPoint(CGPointMake(17.6, 22.06), controlPoint1: CGPointMake(16.5, 25), controlPoint2: CGPointMake(17.6, 23.9))
        bezier4Path.addLineToPoint(CGPointMake(17.6, 13.24))
        bezier4Path.addLineToPoint(CGPointMake(26.4, 13.24))
        bezier4Path.addLineToPoint(CGPointMake(26.4, 22.06))
        bezier4Path.addCurveToPoint(CGPointMake(29.33, 25), controlPoint1: CGPointMake(26.4, 23.9), controlPoint2: CGPointMake(27.5, 25))
        bezier4Path.addLineToPoint(CGPointMake(32.27, 25))
        bezier4Path.addCurveToPoint(CGPointMake(35.2, 22.06), controlPoint1: CGPointMake(34.1, 25), controlPoint2: CGPointMake(35.2, 23.9))
        bezier4Path.addLineToPoint(CGPointMake(35.2, 2.94))
        bezier4Path.addCurveToPoint(CGPointMake(32.27, 0), controlPoint1: CGPointMake(35.2, 1.1), controlPoint2: CGPointMake(34.1, 0))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(43.27, 11.76))
        bezier6Path.addLineToPoint(CGPointMake(42.53, 11.76))
        bezier6Path.addLineToPoint(CGPointMake(42.53, 7.35))
        bezier6Path.addCurveToPoint(CGPointMake(39.6, 4.41), controlPoint1: CGPointMake(42.53, 5.96), controlPoint2: CGPointMake(40.99, 4.41))
        bezier6Path.addLineToPoint(CGPointMake(37.4, 4.41))
        bezier6Path.addCurveToPoint(CGPointMake(36.67, 5.15), controlPoint1: CGPointMake(36.96, 4.41), controlPoint2: CGPointMake(36.67, 4.71))
        bezier6Path.addLineToPoint(CGPointMake(36.67, 19.85))
        bezier6Path.addCurveToPoint(CGPointMake(37.4, 20.59), controlPoint1: CGPointMake(36.67, 20.29), controlPoint2: CGPointMake(36.96, 20.59))
        bezier6Path.addLineToPoint(CGPointMake(39.6, 20.59))
        bezier6Path.addCurveToPoint(CGPointMake(42.53, 17.65), controlPoint1: CGPointMake(40.99, 20.59), controlPoint2: CGPointMake(42.53, 19.04))
        bezier6Path.addLineToPoint(CGPointMake(42.53, 13.24))
        bezier6Path.addLineToPoint(CGPointMake(43.27, 13.24))
        bezier6Path.addCurveToPoint(CGPointMake(44, 12.5), controlPoint1: CGPointMake(43.71, 13.24), controlPoint2: CGPointMake(44, 12.94))
        bezier6Path.addCurveToPoint(CGPointMake(43.27, 11.76), controlPoint1: CGPointMake(44, 12.06), controlPoint2: CGPointMake(43.63, 11.76))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        CGContextRestoreGState(context)
    }
}
