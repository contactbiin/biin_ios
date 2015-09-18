//  BNIcon_TechnologyMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_TechnologyMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(13.48, 0))
        bezier2Path.addLineToPoint(CGPointMake(2.7, 0))
        bezier2Path.addCurveToPoint(CGPointMake(0, 2.59), controlPoint1: CGPointMake(1.21, 0), controlPoint2: CGPointMake(0, 1.17))
        bezier2Path.addLineToPoint(CGPointMake(0, 4.32))
        bezier2Path.addLineToPoint(CGPointMake(0, 21.59))
        bezier2Path.addLineToPoint(CGPointMake(0, 23.32))
        bezier2Path.addCurveToPoint(CGPointMake(2.7, 25.91), controlPoint1: CGPointMake(0, 24.75), controlPoint2: CGPointMake(1.21, 25.91))
        bezier2Path.addLineToPoint(CGPointMake(13.48, 25.91))
        bezier2Path.addCurveToPoint(CGPointMake(16.18, 23.32), controlPoint1: CGPointMake(14.97, 25.91), controlPoint2: CGPointMake(16.18, 24.75))
        bezier2Path.addLineToPoint(CGPointMake(16.18, 21.59))
        bezier2Path.addLineToPoint(CGPointMake(16.18, 4.32))
        bezier2Path.addLineToPoint(CGPointMake(16.18, 2.59))
        bezier2Path.addCurveToPoint(CGPointMake(13.48, 0), controlPoint1: CGPointMake(16.18, 1.17), controlPoint2: CGPointMake(14.97, 0))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(4.94, 2.59))
        bezier2Path.addLineToPoint(CGPointMake(11.24, 2.59))
        bezier2Path.addCurveToPoint(CGPointMake(11.69, 3.02), controlPoint1: CGPointMake(11.51, 2.59), controlPoint2: CGPointMake(11.69, 2.76))
        bezier2Path.addCurveToPoint(CGPointMake(11.24, 3.45), controlPoint1: CGPointMake(11.69, 3.28), controlPoint2: CGPointMake(11.51, 3.45))
        bezier2Path.addLineToPoint(CGPointMake(4.94, 3.45))
        bezier2Path.addCurveToPoint(CGPointMake(4.49, 3.02), controlPoint1: CGPointMake(4.67, 3.45), controlPoint2: CGPointMake(4.49, 3.28))
        bezier2Path.addCurveToPoint(CGPointMake(4.94, 2.59), controlPoint1: CGPointMake(4.49, 2.76), controlPoint2: CGPointMake(4.67, 2.59))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(8.09, 24.62))
        bezier2Path.addCurveToPoint(CGPointMake(6.74, 23.32), controlPoint1: CGPointMake(7.33, 24.62), controlPoint2: CGPointMake(6.74, 24.06))
        bezier2Path.addCurveToPoint(CGPointMake(8.09, 22.03), controlPoint1: CGPointMake(6.74, 22.59), controlPoint2: CGPointMake(7.33, 22.03))
        bezier2Path.addCurveToPoint(CGPointMake(9.44, 23.32), controlPoint1: CGPointMake(8.85, 22.03), controlPoint2: CGPointMake(9.44, 22.59))
        bezier2Path.addCurveToPoint(CGPointMake(8.09, 24.62), controlPoint1: CGPointMake(9.44, 24.06), controlPoint2: CGPointMake(8.85, 24.62))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(15.28, 20.73))
        bezier2Path.addLineToPoint(CGPointMake(0.9, 20.73))
        bezier2Path.addLineToPoint(CGPointMake(0.9, 5.18))
        bezier2Path.addLineToPoint(CGPointMake(15.28, 5.18))
        bezier2Path.addLineToPoint(CGPointMake(15.28, 20.73))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}

