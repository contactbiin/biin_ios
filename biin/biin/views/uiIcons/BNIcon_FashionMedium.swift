//  BNIcon_FashionMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_FashionMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(36.91, 20))
        bezier2Path.addCurveToPoint(CGPointMake(36.78, 19.93), controlPoint1: CGPointMake(36.85, 20), controlPoint2: CGPointMake(36.85, 19.93))
        bezier2Path.addLineToPoint(CGPointMake(20.33, 11.05))
        bezier2Path.addCurveToPoint(CGPointMake(20.46, 10.26), controlPoint1: CGPointMake(20.33, 10.66), controlPoint2: CGPointMake(20.4, 10.39))
        bezier2Path.addCurveToPoint(CGPointMake(20.79, 10.13), controlPoint1: CGPointMake(20.6, 10.2), controlPoint2: CGPointMake(20.66, 10.13))
        bezier2Path.addCurveToPoint(CGPointMake(24.27, 5.26), controlPoint1: CGPointMake(22.3, 9.41), controlPoint2: CGPointMake(24.27, 8.49))
        bezier2Path.addCurveToPoint(CGPointMake(19.02, 0), controlPoint1: CGPointMake(24.27, 2.37), controlPoint2: CGPointMake(21.91, 0))
        bezier2Path.addCurveToPoint(CGPointMake(13.78, 5.26), controlPoint1: CGPointMake(16.14, 0), controlPoint2: CGPointMake(13.78, 2.37))
        bezier2Path.addCurveToPoint(CGPointMake(15.09, 6.58), controlPoint1: CGPointMake(13.78, 5.99), controlPoint2: CGPointMake(14.37, 6.58))
        bezier2Path.addCurveToPoint(CGPointMake(16.4, 5.26), controlPoint1: CGPointMake(15.81, 6.58), controlPoint2: CGPointMake(16.4, 5.99))
        bezier2Path.addCurveToPoint(CGPointMake(19.02, 2.63), controlPoint1: CGPointMake(16.4, 3.82), controlPoint2: CGPointMake(17.58, 2.63))
        bezier2Path.addCurveToPoint(CGPointMake(21.64, 5.26), controlPoint1: CGPointMake(20.46, 2.63), controlPoint2: CGPointMake(21.64, 3.82))
        bezier2Path.addCurveToPoint(CGPointMake(19.61, 7.76), controlPoint1: CGPointMake(21.64, 6.78), controlPoint2: CGPointMake(21.12, 7.04))
        bezier2Path.addCurveToPoint(CGPointMake(19.09, 8.03), controlPoint1: CGPointMake(19.42, 7.83), controlPoint2: CGPointMake(19.22, 7.96))
        bezier2Path.addCurveToPoint(CGPointMake(17.71, 11.05), controlPoint1: CGPointMake(17.97, 8.55), controlPoint2: CGPointMake(17.78, 9.93))
        bezier2Path.addLineToPoint(CGPointMake(1.26, 19.93))
        bezier2Path.addCurveToPoint(CGPointMake(1.13, 20), controlPoint1: CGPointMake(1.2, 19.93), controlPoint2: CGPointMake(1.2, 20))
        bezier2Path.addCurveToPoint(CGPointMake(0.15, 23.16), controlPoint1: CGPointMake(0.15, 20.66), controlPoint2: CGPointMake(-0.24, 21.97))
        bezier2Path.addCurveToPoint(CGPointMake(2.51, 25), controlPoint1: CGPointMake(0.48, 24.28), controlPoint2: CGPointMake(1.46, 25))
        bezier2Path.addLineToPoint(CGPointMake(35.47, 25))
        bezier2Path.addCurveToPoint(CGPointMake(37.83, 23.16), controlPoint1: CGPointMake(36.59, 25), controlPoint2: CGPointMake(37.5, 24.28))
        bezier2Path.addCurveToPoint(CGPointMake(36.91, 20), controlPoint1: CGPointMake(38.29, 21.91), controlPoint2: CGPointMake(37.9, 20.66))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(35.41, 22.37))
        bezier2Path.addLineToPoint(CGPointMake(2.64, 22.37))
        bezier2Path.addCurveToPoint(CGPointMake(2.64, 22.17), controlPoint1: CGPointMake(2.64, 22.3), controlPoint2: CGPointMake(2.58, 22.17))
        bezier2Path.addLineToPoint(CGPointMake(19.02, 13.36))
        bezier2Path.addLineToPoint(CGPointMake(35.41, 22.17))
        bezier2Path.addCurveToPoint(CGPointMake(35.41, 22.37), controlPoint1: CGPointMake(35.41, 22.24), controlPoint2: CGPointMake(35.41, 22.3))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}

