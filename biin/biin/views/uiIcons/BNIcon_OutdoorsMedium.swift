//
//  BNIcon_OutdoorsMedium.swift
//  biin
//
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class BNIcon_OutdoorsMedium:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// tree Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        var treePath = UIBezierPath()
        treePath.moveToPoint(CGPointMake(18.4, 20.89))
        treePath.addLineToPoint(CGPointMake(13.25, 14.41))
        treePath.addLineToPoint(CGPointMake(16.29, 14.41))
        treePath.addCurveToPoint(CGPointMake(16.69, 14.13), controlPoint1: CGPointMake(16.47, 14.41), controlPoint2: CGPointMake(16.6, 14.32))
        treePath.addCurveToPoint(CGPointMake(16.64, 13.64), controlPoint1: CGPointMake(16.77, 14), controlPoint2: CGPointMake(16.73, 13.77))
        treePath.addLineToPoint(CGPointMake(12.37, 8.05))
        treePath.addLineToPoint(CGPointMake(14.09, 8.05))
        treePath.addCurveToPoint(CGPointMake(14.49, 7.83), controlPoint1: CGPointMake(14.27, 8.05), controlPoint2: CGPointMake(14.4, 7.96))
        treePath.addCurveToPoint(CGPointMake(14.44, 7.38), controlPoint1: CGPointMake(14.57, 7.69), controlPoint2: CGPointMake(14.53, 7.51))
        treePath.addLineToPoint(CGPointMake(9.6, 0.17))
        treePath.addCurveToPoint(CGPointMake(8.9, 0.17), controlPoint1: CGPointMake(9.42, -0.06), controlPoint2: CGPointMake(9.03, -0.06))
        treePath.addLineToPoint(CGPointMake(4.05, 7.38))
        treePath.addCurveToPoint(CGPointMake(4.01, 7.83), controlPoint1: CGPointMake(3.97, 7.51), controlPoint2: CGPointMake(3.97, 7.69))
        treePath.addCurveToPoint(CGPointMake(4.41, 8.05), controlPoint1: CGPointMake(4.1, 7.96), controlPoint2: CGPointMake(4.23, 8.05))
        treePath.addLineToPoint(CGPointMake(6.12, 8.05))
        treePath.addLineToPoint(CGPointMake(1.85, 13.68))
        treePath.addCurveToPoint(CGPointMake(1.81, 14.18), controlPoint1: CGPointMake(1.76, 13.82), controlPoint2: CGPointMake(1.72, 14))
        treePath.addCurveToPoint(CGPointMake(2.2, 14.45), controlPoint1: CGPointMake(1.9, 14.32), controlPoint2: CGPointMake(2.03, 14.45))
        treePath.addLineToPoint(CGPointMake(5.24, 14.45))
        treePath.addLineToPoint(CGPointMake(0.09, 20.89))
        treePath.addCurveToPoint(CGPointMake(0.05, 21.39), controlPoint1: CGPointMake(0, 21.03), controlPoint2: CGPointMake(-0.04, 21.21))
        treePath.addCurveToPoint(CGPointMake(0.44, 21.66), controlPoint1: CGPointMake(0.14, 21.52), controlPoint2: CGPointMake(0.27, 21.66))
        treePath.addLineToPoint(CGPointMake(8.81, 21.66))
        treePath.addLineToPoint(CGPointMake(8.81, 26.61))
        treePath.addCurveToPoint(CGPointMake(9.25, 27.06), controlPoint1: CGPointMake(8.81, 26.88), controlPoint2: CGPointMake(8.98, 27.06))
        treePath.addCurveToPoint(CGPointMake(9.69, 26.61), controlPoint1: CGPointMake(9.51, 27.06), controlPoint2: CGPointMake(9.69, 26.88))
        treePath.addLineToPoint(CGPointMake(9.69, 21.66))
        treePath.addLineToPoint(CGPointMake(18.05, 21.66))
        treePath.addCurveToPoint(CGPointMake(18.45, 21.39), controlPoint1: CGPointMake(18.23, 21.66), controlPoint2: CGPointMake(18.36, 21.57))
        treePath.addCurveToPoint(CGPointMake(18.4, 20.89), controlPoint1: CGPointMake(18.54, 21.21), controlPoint2: CGPointMake(18.49, 21.03))
        treePath.closePath()
        treePath.miterLimit = 4;
        
        color!.setFill()
        treePath.fill()
        
        CGContextRestoreGState(context)
    }
}
