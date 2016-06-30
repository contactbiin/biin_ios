//  BNIcon_EntertaimentMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.


import Foundation
import QuartzCore
import UIKit

class BNIcon_EntertaimentMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(24.14, 0.05))
        bezier2Path.addCurveToPoint(CGPointMake(23.64, 0.13), controlPoint1: CGPointMake(23.96, -0.04), controlPoint2: CGPointMake(23.78, 0))
        bezier2Path.addCurveToPoint(CGPointMake(12.21, 2.08), controlPoint1: CGPointMake(22.47, 1.29), controlPoint2: CGPointMake(17.77, 2.08))
        bezier2Path.addLineToPoint(CGPointMake(12.21, 2.08))
        bezier2Path.addCurveToPoint(CGPointMake(0.77, 0.13), controlPoint1: CGPointMake(6.55, 2.08), controlPoint2: CGPointMake(1.99, 1.29))
        bezier2Path.addCurveToPoint(CGPointMake(0.27, 0.05), controlPoint1: CGPointMake(0.63, 0), controlPoint2: CGPointMake(0.45, -0.04))
        bezier2Path.addCurveToPoint(CGPointMake(0, 0.44), controlPoint1: CGPointMake(0.09, 0.09), controlPoint2: CGPointMake(0, 0.27))
        bezier2Path.addLineToPoint(CGPointMake(0, 13.28))
        bezier2Path.addCurveToPoint(CGPointMake(12.21, 26.57), controlPoint1: CGPointMake(0, 20.77), controlPoint2: CGPointMake(9.72, 26.57))
        bezier2Path.addCurveToPoint(CGPointMake(24.41, 13.28), controlPoint1: CGPointMake(14.69, 26.57), controlPoint2: CGPointMake(24.41, 20.77))
        bezier2Path.addLineToPoint(CGPointMake(24.41, 0.44))
        bezier2Path.addCurveToPoint(CGPointMake(24.14, 0.05), controlPoint1: CGPointMake(24.41, 0.27), controlPoint2: CGPointMake(24.32, 0.09))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(5.42, 9.74))
        bezier2Path.addCurveToPoint(CGPointMake(4.97, 10.18), controlPoint1: CGPointMake(5.42, 10.01), controlPoint2: CGPointMake(5.24, 10.18))
        bezier2Path.addCurveToPoint(CGPointMake(4.52, 9.74), controlPoint1: CGPointMake(4.7, 10.18), controlPoint2: CGPointMake(4.52, 10.01))
        bezier2Path.addCurveToPoint(CGPointMake(7.23, 7.09), controlPoint1: CGPointMake(4.52, 8.28), controlPoint2: CGPointMake(5.74, 7.09))
        bezier2Path.addCurveToPoint(CGPointMake(9.94, 9.74), controlPoint1: CGPointMake(8.72, 7.09), controlPoint2: CGPointMake(9.94, 8.28))
        bezier2Path.addCurveToPoint(CGPointMake(9.49, 10.18), controlPoint1: CGPointMake(9.94, 10.01), controlPoint2: CGPointMake(9.76, 10.18))
        bezier2Path.addCurveToPoint(CGPointMake(9.04, 9.74), controlPoint1: CGPointMake(9.22, 10.18), controlPoint2: CGPointMake(9.04, 10.01))
        bezier2Path.addCurveToPoint(CGPointMake(7.23, 7.97), controlPoint1: CGPointMake(9.04, 8.77), controlPoint2: CGPointMake(8.23, 7.97))
        bezier2Path.addCurveToPoint(CGPointMake(5.42, 9.74), controlPoint1: CGPointMake(6.24, 7.97), controlPoint2: CGPointMake(5.42, 8.77))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(12.21, 20.37))
        bezier2Path.addCurveToPoint(CGPointMake(7.23, 15.5), controlPoint1: CGPointMake(9.45, 20.37), controlPoint2: CGPointMake(7.23, 18.2))
        bezier2Path.addCurveToPoint(CGPointMake(7.68, 15.06), controlPoint1: CGPointMake(7.23, 15.23), controlPoint2: CGPointMake(7.41, 15.06))
        bezier2Path.addCurveToPoint(CGPointMake(8.14, 15.5), controlPoint1: CGPointMake(7.96, 15.06), controlPoint2: CGPointMake(8.14, 15.23))
        bezier2Path.addCurveToPoint(CGPointMake(12.21, 19.48), controlPoint1: CGPointMake(8.14, 17.71), controlPoint2: CGPointMake(9.94, 19.48))
        bezier2Path.addCurveToPoint(CGPointMake(16.27, 15.5), controlPoint1: CGPointMake(14.47, 19.48), controlPoint2: CGPointMake(16.27, 17.71))
        bezier2Path.addCurveToPoint(CGPointMake(16.73, 15.06), controlPoint1: CGPointMake(16.27, 15.23), controlPoint2: CGPointMake(16.45, 15.06))
        bezier2Path.addCurveToPoint(CGPointMake(17.18, 15.5), controlPoint1: CGPointMake(17, 15.06), controlPoint2: CGPointMake(17.18, 15.23))
        bezier2Path.addCurveToPoint(CGPointMake(12.21, 20.37), controlPoint1: CGPointMake(17.18, 18.2), controlPoint2: CGPointMake(14.96, 20.37))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(19.44, 10.18))
        bezier2Path.addCurveToPoint(CGPointMake(18.99, 9.74), controlPoint1: CGPointMake(19.17, 10.18), controlPoint2: CGPointMake(18.99, 10.01))
        bezier2Path.addCurveToPoint(CGPointMake(17.18, 7.97), controlPoint1: CGPointMake(18.99, 8.77), controlPoint2: CGPointMake(18.17, 7.97))
        bezier2Path.addCurveToPoint(CGPointMake(15.37, 9.74), controlPoint1: CGPointMake(16.18, 7.97), controlPoint2: CGPointMake(15.37, 8.77))
        bezier2Path.addCurveToPoint(CGPointMake(14.92, 10.18), controlPoint1: CGPointMake(15.37, 10.01), controlPoint2: CGPointMake(15.19, 10.18))
        bezier2Path.addCurveToPoint(CGPointMake(14.47, 9.74), controlPoint1: CGPointMake(14.65, 10.18), controlPoint2: CGPointMake(14.47, 10.01))
        bezier2Path.addCurveToPoint(CGPointMake(17.18, 7.09), controlPoint1: CGPointMake(14.47, 8.28), controlPoint2: CGPointMake(15.69, 7.09))
        bezier2Path.addCurveToPoint(CGPointMake(19.89, 9.74), controlPoint1: CGPointMake(18.67, 7.09), controlPoint2: CGPointMake(19.89, 8.28))
        bezier2Path.addCurveToPoint(CGPointMake(19.44, 10.18), controlPoint1: CGPointMake(19.89, 10.01), controlPoint2: CGPointMake(19.71, 10.18))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}

