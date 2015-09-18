//  BNIcon_CommentMedium.swift
//  biin
//  Created by Esteban Padilla on 2/28/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_CommentMedium:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Bezier 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(13.48, 0))
        bezier2Path.addCurveToPoint(CGPointMake(0, 11.47), controlPoint1: CGPointMake(6.06, 0), controlPoint2: CGPointMake(0, 5.15))
        bezier2Path.addCurveToPoint(CGPointMake(3.82, 19.45), controlPoint1: CGPointMake(0, 14.49), controlPoint2: CGPointMake(1.35, 17.27))
        bezier2Path.addLineToPoint(CGPointMake(0.99, 25.35))
        bezier2Path.addCurveToPoint(CGPointMake(1.08, 25.86), controlPoint1: CGPointMake(0.9, 25.54), controlPoint2: CGPointMake(0.94, 25.72))
        bezier2Path.addCurveToPoint(CGPointMake(1.39, 26), controlPoint1: CGPointMake(1.17, 25.95), controlPoint2: CGPointMake(1.26, 26))
        bezier2Path.addCurveToPoint(CGPointMake(1.57, 25.95), controlPoint1: CGPointMake(1.44, 26), controlPoint2: CGPointMake(1.53, 26))
        bezier2Path.addLineToPoint(CGPointMake(8.99, 22.24))
        bezier2Path.addCurveToPoint(CGPointMake(13.52, 22.89), controlPoint1: CGPointMake(10.42, 22.66), controlPoint2: CGPointMake(11.95, 22.89))
        bezier2Path.addCurveToPoint(CGPointMake(27, 11.42), controlPoint1: CGPointMake(20.94, 22.89), controlPoint2: CGPointMake(27, 17.74))
        bezier2Path.addCurveToPoint(CGPointMake(13.48, 0), controlPoint1: CGPointMake(26.96, 5.15), controlPoint2: CGPointMake(20.94, 0))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(17.48, 6.45))
        bezier2Path.addCurveToPoint(CGPointMake(20.17, 9.24), controlPoint1: CGPointMake(18.96, 6.45), controlPoint2: CGPointMake(20.17, 7.71))
        bezier2Path.addCurveToPoint(CGPointMake(19.72, 9.7), controlPoint1: CGPointMake(20.17, 9.52), controlPoint2: CGPointMake(19.99, 9.7))
        bezier2Path.addCurveToPoint(CGPointMake(19.54, 8.73), controlPoint1: CGPointMake(19.32, 9.7), controlPoint2: CGPointMake(19.05, 9.15))
        bezier2Path.addCurveToPoint(CGPointMake(15.63, 9.24), controlPoint1: CGPointMake(17.93, 6.31), controlPoint2: CGPointMake(15.63, 7.52))
        bezier2Path.addCurveToPoint(CGPointMake(15.18, 9.7), controlPoint1: CGPointMake(15.63, 9.52), controlPoint2: CGPointMake(15.45, 9.7))
        bezier2Path.addCurveToPoint(CGPointMake(14.74, 9.24), controlPoint1: CGPointMake(14.92, 9.7), controlPoint2: CGPointMake(14.74, 9.52))
        bezier2Path.addCurveToPoint(CGPointMake(17.48, 6.45), controlPoint1: CGPointMake(14.74, 7.71), controlPoint2: CGPointMake(15.95, 6.45))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(9.52, 6.45))
        bezier2Path.addCurveToPoint(CGPointMake(12.22, 9.24), controlPoint1: CGPointMake(11.01, 6.45), controlPoint2: CGPointMake(12.22, 7.71))
        bezier2Path.addCurveToPoint(CGPointMake(11.77, 9.7), controlPoint1: CGPointMake(12.22, 9.52), controlPoint2: CGPointMake(12.04, 9.7))
        bezier2Path.addCurveToPoint(CGPointMake(11.59, 8.73), controlPoint1: CGPointMake(11.37, 9.7), controlPoint2: CGPointMake(11.1, 9.15))
        bezier2Path.addCurveToPoint(CGPointMake(7.68, 9.24), controlPoint1: CGPointMake(9.97, 6.31), controlPoint2: CGPointMake(7.68, 7.52))
        bezier2Path.addCurveToPoint(CGPointMake(7.23, 9.7), controlPoint1: CGPointMake(7.68, 9.52), controlPoint2: CGPointMake(7.5, 9.7))
        bezier2Path.addCurveToPoint(CGPointMake(6.78, 9.24), controlPoint1: CGPointMake(6.96, 9.7), controlPoint2: CGPointMake(6.78, 9.52))
        bezier2Path.addCurveToPoint(CGPointMake(9.52, 6.45), controlPoint1: CGPointMake(6.83, 7.71), controlPoint2: CGPointMake(8.04, 6.45))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(15.77, 17.64))
        bezier2Path.addLineToPoint(CGPointMake(11.23, 17.64))
        bezier2Path.addCurveToPoint(CGPointMake(5.66, 12.16), controlPoint1: CGPointMake(8.13, 17.64), controlPoint2: CGPointMake(5.66, 15.23))
        bezier2Path.addCurveToPoint(CGPointMake(6.11, 11.7), controlPoint1: CGPointMake(5.66, 11.89), controlPoint2: CGPointMake(5.84, 11.7))
        bezier2Path.addCurveToPoint(CGPointMake(6.56, 12.16), controlPoint1: CGPointMake(6.38, 11.7), controlPoint2: CGPointMake(6.56, 11.89))
        bezier2Path.addCurveToPoint(CGPointMake(11.23, 16.71), controlPoint1: CGPointMake(6.56, 14.72), controlPoint2: CGPointMake(8.63, 16.71))
        bezier2Path.addLineToPoint(CGPointMake(15.77, 16.71))
        bezier2Path.addCurveToPoint(CGPointMake(20.4, 12.16), controlPoint1: CGPointMake(18.42, 16.71), controlPoint2: CGPointMake(20.4, 14.76))
        bezier2Path.addCurveToPoint(CGPointMake(20.85, 11.7), controlPoint1: CGPointMake(20.4, 11.89), controlPoint2: CGPointMake(20.58, 11.7))
        bezier2Path.addCurveToPoint(CGPointMake(21.29, 12.16), controlPoint1: CGPointMake(21.11, 11.7), controlPoint2: CGPointMake(21.29, 11.89))
        bezier2Path.addCurveToPoint(CGPointMake(15.77, 17.64), controlPoint1: CGPointMake(21.29, 15.27), controlPoint2: CGPointMake(18.87, 17.64))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        CGContextRestoreGState(context)
    }
}

