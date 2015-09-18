//  BNIcon_SportMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_SportMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(22.04, 6.93))
        bezier2Path.addCurveToPoint(CGPointMake(12.84, 3.21), controlPoint1: CGPointMake(19.93, 4.59), controlPoint2: CGPointMake(15.79, 3.21))
        bezier2Path.addCurveToPoint(CGPointMake(6.79, 5.33), controlPoint1: CGPointMake(10.66, 3.21), controlPoint2: CGPointMake(8.59, 3.94))
        bezier2Path.addCurveToPoint(CGPointMake(6.25, 5.2), controlPoint1: CGPointMake(6.59, 5.46), controlPoint2: CGPointMake(6.36, 5.42))
        bezier2Path.addCurveToPoint(CGPointMake(6.36, 4.59), controlPoint1: CGPointMake(6.13, 4.98), controlPoint2: CGPointMake(6.17, 4.72))
        bezier2Path.addCurveToPoint(CGPointMake(12.84, 2.34), controlPoint1: CGPointMake(8.28, 3.12), controlPoint2: CGPointMake(10.5, 2.34))
        bezier2Path.addCurveToPoint(CGPointMake(20.28, 4.42), controlPoint1: CGPointMake(15.07, 2.34), controlPoint2: CGPointMake(17.98, 3.08))
        bezier2Path.addCurveToPoint(CGPointMake(11.12, 0), controlPoint1: CGPointMake(18.25, 2.12), controlPoint2: CGPointMake(15.14, 0))
        bezier2Path.addCurveToPoint(CGPointMake(1.76, 2.9), controlPoint1: CGPointMake(6.59, 0), controlPoint2: CGPointMake(2.61, 1.91))
        bezier2Path.addCurveToPoint(CGPointMake(1.53, 3.47), controlPoint1: CGPointMake(1.61, 3.12), controlPoint2: CGPointMake(1.53, 3.29))
        bezier2Path.addLineToPoint(CGPointMake(1.53, 4.9))
        bezier2Path.addCurveToPoint(CGPointMake(0, 7.8), controlPoint1: CGPointMake(0.61, 5.5), controlPoint2: CGPointMake(0, 6.59))
        bezier2Path.addCurveToPoint(CGPointMake(2.34, 12.05), controlPoint1: CGPointMake(0, 9.49), controlPoint2: CGPointMake(1.3, 11.61))
        bezier2Path.addCurveToPoint(CGPointMake(3.83, 16.47), controlPoint1: CGPointMake(2.45, 13.22), controlPoint2: CGPointMake(2.95, 16.47))
        bezier2Path.addLineToPoint(CGPointMake(3.83, 16.47))
        bezier2Path.addLineToPoint(CGPointMake(3.83, 16.47))
        bezier2Path.addLineToPoint(CGPointMake(3.83, 16.47))
        bezier2Path.addLineToPoint(CGPointMake(10, 16.47))
        bezier2Path.addCurveToPoint(CGPointMake(11.5, 18.16), controlPoint1: CGPointMake(10.16, 17.33), controlPoint2: CGPointMake(10.73, 17.98))
        bezier2Path.addLineToPoint(CGPointMake(11.5, 21.67))
        bezier2Path.addLineToPoint(CGPointMake(11.12, 21.67))
        bezier2Path.addCurveToPoint(CGPointMake(10.73, 22.1), controlPoint1: CGPointMake(10.89, 21.67), controlPoint2: CGPointMake(10.73, 21.84))
        bezier2Path.addLineToPoint(CGPointMake(10.73, 25.57))
        bezier2Path.addCurveToPoint(CGPointMake(11.12, 26), controlPoint1: CGPointMake(10.73, 25.83), controlPoint2: CGPointMake(10.89, 26))
        bezier2Path.addLineToPoint(CGPointMake(12.65, 26))
        bezier2Path.addCurveToPoint(CGPointMake(13.03, 25.57), controlPoint1: CGPointMake(12.88, 26), controlPoint2: CGPointMake(13.03, 25.83))
        bezier2Path.addLineToPoint(CGPointMake(13.03, 22.1))
        bezier2Path.addCurveToPoint(CGPointMake(12.65, 21.67), controlPoint1: CGPointMake(13.03, 21.84), controlPoint2: CGPointMake(12.88, 21.67))
        bezier2Path.addLineToPoint(CGPointMake(12.27, 21.67))
        bezier2Path.addLineToPoint(CGPointMake(12.27, 18.16))
        bezier2Path.addCurveToPoint(CGPointMake(13.8, 16.03), controlPoint1: CGPointMake(13.15, 17.94), controlPoint2: CGPointMake(13.8, 17.07))
        bezier2Path.addCurveToPoint(CGPointMake(12.27, 13.91), controlPoint1: CGPointMake(13.8, 14.99), controlPoint2: CGPointMake(13.15, 14.13))
        bezier2Path.addLineToPoint(CGPointMake(12.27, 12.13))
        bezier2Path.addLineToPoint(CGPointMake(21.08, 12.13))
        bezier2Path.addCurveToPoint(CGPointMake(23, 9.53), controlPoint1: CGPointMake(22.08, 12.13), controlPoint2: CGPointMake(23, 10.66))
        bezier2Path.addCurveToPoint(CGPointMake(22.04, 6.93), controlPoint1: CGPointMake(23, 9.01), controlPoint2: CGPointMake(22.65, 8.06))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(3.8, 15.47))
        bezier2Path.addCurveToPoint(CGPointMake(3.07, 12.18), controlPoint1: CGPointMake(3.53, 14.86), controlPoint2: CGPointMake(3.14, 13.22))
        bezier2Path.addLineToPoint(CGPointMake(6.71, 12.18))
        bezier2Path.addLineToPoint(CGPointMake(3.8, 15.47))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(11.5, 13.95))
        bezier2Path.addCurveToPoint(CGPointMake(10, 15.64), controlPoint1: CGPointMake(10.73, 14.13), controlPoint2: CGPointMake(10.16, 14.78))
        bezier2Path.addLineToPoint(CGPointMake(4.75, 15.64))
        bezier2Path.addLineToPoint(CGPointMake(7.82, 12.18))
        bezier2Path.addLineToPoint(CGPointMake(11.5, 12.18))
        bezier2Path.addLineToPoint(CGPointMake(11.5, 13.95))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        
        CGContextRestoreGState(context)

    }
}

