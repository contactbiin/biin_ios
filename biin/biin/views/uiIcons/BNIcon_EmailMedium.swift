//  BNIcon_EmailMedium.swift
//  biin
//  Created by Esteban Padilla on 2/28/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_EmailMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(24.27, 9.47))
        bezier2Path.addCurveToPoint(CGPointMake(24.92, 9.47), controlPoint1: CGPointMake(24.45, 9.28), controlPoint2: CGPointMake(24.73, 9.28))
        bezier2Path.addLineToPoint(CGPointMake(25.2, 9.76))
        bezier2Path.addLineToPoint(CGPointMake(25.2, 2.79))
        bezier2Path.addCurveToPoint(CGPointMake(24.87, 1.2), controlPoint1: CGPointMake(25.2, 2.16), controlPoint2: CGPointMake(25.11, 1.63))
        bezier2Path.addLineToPoint(CGPointMake(13.58, 10.67))
        bezier2Path.addCurveToPoint(CGPointMake(13.3, 10.77), controlPoint1: CGPointMake(13.49, 10.72), controlPoint2: CGPointMake(13.39, 10.77))
        bezier2Path.addCurveToPoint(CGPointMake(13.02, 10.67), controlPoint1: CGPointMake(13.21, 10.77), controlPoint2: CGPointMake(13.11, 10.72))
        bezier2Path.addLineToPoint(CGPointMake(0.42, 1.25))
        bezier2Path.addCurveToPoint(CGPointMake(0, 2.79), controlPoint1: CGPointMake(0.14, 1.68), controlPoint2: CGPointMake(0, 2.21))
        bezier2Path.addLineToPoint(CGPointMake(0, 14.38))
        bezier2Path.addCurveToPoint(CGPointMake(2.75, 17.26), controlPoint1: CGPointMake(0, 15.91), controlPoint2: CGPointMake(1.21, 17.16))
        bezier2Path.addLineToPoint(CGPointMake(16.66, 17.26))
        bezier2Path.addLineToPoint(CGPointMake(24.27, 9.47))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(24.31, 0.48))
        bezier4Path.addCurveToPoint(CGPointMake(22.82, 0), controlPoint1: CGPointMake(23.94, 0.14), controlPoint2: CGPointMake(23.43, 0))
        bezier4Path.addLineToPoint(CGPointMake(2.85, 0))
        bezier4Path.addCurveToPoint(CGPointMake(1.07, 0.58), controlPoint1: CGPointMake(2.15, 0), controlPoint2: CGPointMake(1.54, 0.19))
        bezier4Path.addLineToPoint(CGPointMake(13.3, 9.66))
        bezier4Path.addLineToPoint(CGPointMake(24.31, 0.48))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(18.01, 17.31))
        bezier6Path.addLineToPoint(CGPointMake(18.01, 17.31))
        bezier6Path.addLineToPoint(CGPointMake(15.77, 19.57))
        bezier6Path.addLineToPoint(CGPointMake(19.37, 23.27))
        bezier6Path.addLineToPoint(CGPointMake(25.2, 17.31))
        bezier6Path.addLineToPoint(CGPointMake(21.61, 13.61))
        bezier6Path.addLineToPoint(CGPointMake(18.01, 17.31))
        bezier6Path.closePath()
        bezier6Path.miterLimit = 4;
        
        color!.setFill()
        bezier6Path.fill()
        
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(27.86, 13.85))
        bezier8Path.addLineToPoint(CGPointMake(25.2, 11.11))
        bezier8Path.addLineToPoint(CGPointMake(25.2, 11.11))
        bezier8Path.addLineToPoint(CGPointMake(24.59, 10.48))
        bezier8Path.addLineToPoint(CGPointMake(22.26, 12.88))
        bezier8Path.addLineToPoint(CGPointMake(25.85, 16.59))
        bezier8Path.addLineToPoint(CGPointMake(27.86, 14.52))
        bezier8Path.addCurveToPoint(CGPointMake(28, 14.18), controlPoint1: CGPointMake(27.95, 14.42), controlPoint2: CGPointMake(28, 14.33))
        bezier8Path.addCurveToPoint(CGPointMake(27.86, 13.85), controlPoint1: CGPointMake(28, 14.09), controlPoint2: CGPointMake(27.95, 13.94))
        bezier8Path.closePath()
        bezier8Path.miterLimit = 4;
        
        color!.setFill()
        bezier8Path.fill()
        
        
        //// Bezier 10 Drawing
        let bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(14.14, 24.38))
        bezier10Path.addCurveToPoint(CGPointMake(14.28, 24.86), controlPoint1: CGPointMake(14.09, 24.52), controlPoint2: CGPointMake(14.14, 24.71))
        bezier10Path.addCurveToPoint(CGPointMake(14.61, 25), controlPoint1: CGPointMake(14.37, 24.95), controlPoint2: CGPointMake(14.47, 25))
        bezier10Path.addCurveToPoint(CGPointMake(14.75, 25), controlPoint1: CGPointMake(14.65, 25), controlPoint2: CGPointMake(14.7, 25))
        bezier10Path.addLineToPoint(CGPointMake(18.62, 23.85))
        bezier10Path.addLineToPoint(CGPointMake(15.26, 20.38))
        bezier10Path.addLineToPoint(CGPointMake(14.14, 24.38))
        bezier10Path.closePath()
        bezier10Path.miterLimit = 4;
        
        color!.setFill()
        bezier10Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}
