//  BNIcon_PigSmall.swift
//  biin
//  Created by Esteban Padilla on 2/5/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_PigSmall:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// pig Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        let pigPath = UIBezierPath()
        pigPath.moveToPoint(CGPointMake(27.53, 9.12))
        pigPath.addCurveToPoint(CGPointMake(27.06, 9.6), controlPoint1: CGPointMake(27.27, 9.12), controlPoint2: CGPointMake(27.06, 9.33))
        pigPath.addCurveToPoint(CGPointMake(25.61, 11.48), controlPoint1: CGPointMake(27.06, 10.52), controlPoint2: CGPointMake(26.44, 11.27))
        pigPath.addCurveToPoint(CGPointMake(14, 1.93), controlPoint1: CGPointMake(25.29, 6.17), controlPoint2: CGPointMake(20.19, 1.93))
        pigPath.addCurveToPoint(CGPointMake(11.35, 2.09), controlPoint1: CGPointMake(13.12, 1.93), controlPoint2: CGPointMake(12.23, 1.93))
        pigPath.addCurveToPoint(CGPointMake(7.55, 0), controlPoint1: CGPointMake(10.51, 0.8), controlPoint2: CGPointMake(9.06, 0))
        pigPath.addCurveToPoint(CGPointMake(5.26, 0.64), controlPoint1: CGPointMake(6.77, 0), controlPoint2: CGPointMake(5.93, 0.21))
        pigPath.addCurveToPoint(CGPointMake(5.05, 1.07), controlPoint1: CGPointMake(5.1, 0.75), controlPoint2: CGPointMake(5.05, 0.91))
        pigPath.addCurveToPoint(CGPointMake(5.26, 1.5), controlPoint1: CGPointMake(5.05, 1.23), controlPoint2: CGPointMake(5.15, 1.39))
        pigPath.addCurveToPoint(CGPointMake(6.97, 3.92), controlPoint1: CGPointMake(6.14, 2.04), controlPoint2: CGPointMake(6.77, 2.9))
        pigPath.addCurveToPoint(CGPointMake(2.39, 10.62), controlPoint1: CGPointMake(4.58, 5.53), controlPoint2: CGPointMake(2.91, 7.99))
        pigPath.addLineToPoint(CGPointMake(0.47, 10.62))
        pigPath.addCurveToPoint(CGPointMake(0, 11.11), controlPoint1: CGPointMake(0.21, 10.62), controlPoint2: CGPointMake(0, 10.84))
        pigPath.addLineToPoint(CGPointMake(0, 15.88))
        pigPath.addCurveToPoint(CGPointMake(0.47, 16.36), controlPoint1: CGPointMake(0, 16.15), controlPoint2: CGPointMake(0.21, 16.36))
        pigPath.addLineToPoint(CGPointMake(3.43, 16.36))
        pigPath.addCurveToPoint(CGPointMake(9.32, 21.41), controlPoint1: CGPointMake(4.58, 18.78), controlPoint2: CGPointMake(6.61, 20.49))
        pigPath.addLineToPoint(CGPointMake(9.32, 24.52))
        pigPath.addCurveToPoint(CGPointMake(9.78, 25), controlPoint1: CGPointMake(9.32, 24.79), controlPoint2: CGPointMake(9.52, 25))
        pigPath.addCurveToPoint(CGPointMake(10.25, 24.52), controlPoint1: CGPointMake(10.04, 25), controlPoint2: CGPointMake(10.25, 24.79))
        pigPath.addLineToPoint(CGPointMake(10.25, 21.67))
        pigPath.addCurveToPoint(CGPointMake(14, 22.1), controlPoint1: CGPointMake(11.4, 21.94), controlPoint2: CGPointMake(12.65, 22.1))
        pigPath.addCurveToPoint(CGPointMake(17.75, 21.57), controlPoint1: CGPointMake(15.3, 22.1), controlPoint2: CGPointMake(16.55, 21.89))
        pigPath.addLineToPoint(CGPointMake(17.75, 24.52))
        pigPath.addCurveToPoint(CGPointMake(18.22, 25), controlPoint1: CGPointMake(17.75, 24.79), controlPoint2: CGPointMake(17.96, 25))
        pigPath.addCurveToPoint(CGPointMake(18.68, 24.52), controlPoint1: CGPointMake(18.48, 25), controlPoint2: CGPointMake(18.68, 24.79))
        pigPath.addLineToPoint(CGPointMake(18.68, 21.24))
        pigPath.addCurveToPoint(CGPointMake(25.66, 12.45), controlPoint1: CGPointMake(22.64, 19.74), controlPoint2: CGPointMake(25.4, 16.36))
        pigPath.addCurveToPoint(CGPointMake(28, 9.6), controlPoint1: CGPointMake(27.01, 12.23), controlPoint2: CGPointMake(28, 11.05))
        pigPath.addCurveToPoint(CGPointMake(27.53, 9.12), controlPoint1: CGPointMake(28, 9.33), controlPoint2: CGPointMake(27.79, 9.12))
        pigPath.closePath()
        pigPath.moveToPoint(CGPointMake(19.99, 7.51))
        pigPath.addCurveToPoint(CGPointMake(19.62, 7.73), controlPoint1: CGPointMake(19.88, 7.62), controlPoint2: CGPointMake(19.78, 7.73))
        pigPath.addCurveToPoint(CGPointMake(19.36, 7.62), controlPoint1: CGPointMake(19.52, 7.73), controlPoint2: CGPointMake(19.41, 7.67))
        pigPath.addCurveToPoint(CGPointMake(13.64, 5.79), controlPoint1: CGPointMake(17.7, 6.33), controlPoint2: CGPointMake(15.56, 5.63))
        pigPath.addCurveToPoint(CGPointMake(13.12, 5.36), controlPoint1: CGPointMake(13.38, 5.79), controlPoint2: CGPointMake(13.17, 5.63))
        pigPath.addCurveToPoint(CGPointMake(13.53, 4.83), controlPoint1: CGPointMake(13.12, 5.1), controlPoint2: CGPointMake(13.27, 4.88))
        pigPath.addCurveToPoint(CGPointMake(19.88, 6.81), controlPoint1: CGPointMake(15.67, 4.67), controlPoint2: CGPointMake(18.06, 5.42))
        pigPath.addCurveToPoint(CGPointMake(19.99, 7.51), controlPoint1: CGPointMake(20.09, 6.97), controlPoint2: CGPointMake(20.14, 7.3))
        pigPath.closePath()
        pigPath.miterLimit = 4;
        
        color!.setFill()
        pigPath.fill()
        
        CGContextRestoreGState(context)
    }
}