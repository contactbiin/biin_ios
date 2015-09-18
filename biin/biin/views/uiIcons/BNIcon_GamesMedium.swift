//  BNIcon_GamesMedium.swift
//  biin
//  Created by Esteban Padilla on 2/13/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_GamesMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(35.4, 11.9))
        bezier2Path.addLineToPoint(CGPointMake(32.4, 11.9))
        bezier2Path.addLineToPoint(CGPointMake(32.4, 8.93))
        bezier2Path.addCurveToPoint(CGPointMake(31.8, 8.33), controlPoint1: CGPointMake(32.4, 8.57), controlPoint2: CGPointMake(32.16, 8.33))
        bezier2Path.addLineToPoint(CGPointMake(30, 8.33))
        bezier2Path.addLineToPoint(CGPointMake(30, 6.55))
        bezier2Path.addCurveToPoint(CGPointMake(29.4, 5.95), controlPoint1: CGPointMake(30, 6.19), controlPoint2: CGPointMake(29.76, 5.95))
        bezier2Path.addLineToPoint(CGPointMake(26.4, 5.95))
        bezier2Path.addLineToPoint(CGPointMake(26.4, 4.76))
        bezier2Path.addLineToPoint(CGPointMake(29.4, 4.76))
        bezier2Path.addCurveToPoint(CGPointMake(30, 4.17), controlPoint1: CGPointMake(29.76, 4.76), controlPoint2: CGPointMake(30, 4.52))
        bezier2Path.addLineToPoint(CGPointMake(30, 0.6))
        bezier2Path.addCurveToPoint(CGPointMake(29.4, 0), controlPoint1: CGPointMake(30, 0.24), controlPoint2: CGPointMake(29.76, 0))
        bezier2Path.addLineToPoint(CGPointMake(25.8, 0))
        bezier2Path.addCurveToPoint(CGPointMake(25.2, 0.6), controlPoint1: CGPointMake(25.44, 0), controlPoint2: CGPointMake(25.2, 0.24))
        bezier2Path.addLineToPoint(CGPointMake(25.2, 3.57))
        bezier2Path.addLineToPoint(CGPointMake(22.2, 3.57))
        bezier2Path.addCurveToPoint(CGPointMake(21.6, 4.17), controlPoint1: CGPointMake(21.84, 3.57), controlPoint2: CGPointMake(21.6, 3.81))
        bezier2Path.addLineToPoint(CGPointMake(21.6, 5.95))
        bezier2Path.addLineToPoint(CGPointMake(14.4, 5.95))
        bezier2Path.addLineToPoint(CGPointMake(14.4, 4.17))
        bezier2Path.addCurveToPoint(CGPointMake(13.8, 3.57), controlPoint1: CGPointMake(14.4, 3.81), controlPoint2: CGPointMake(14.16, 3.57))
        bezier2Path.addLineToPoint(CGPointMake(10.8, 3.57))
        bezier2Path.addLineToPoint(CGPointMake(10.8, 0.6))
        bezier2Path.addCurveToPoint(CGPointMake(10.2, 0), controlPoint1: CGPointMake(10.8, 0.24), controlPoint2: CGPointMake(10.56, 0))
        bezier2Path.addLineToPoint(CGPointMake(6.6, 0))
        bezier2Path.addCurveToPoint(CGPointMake(6, 0.6), controlPoint1: CGPointMake(6.24, 0), controlPoint2: CGPointMake(6, 0.24))
        bezier2Path.addLineToPoint(CGPointMake(6, 4.17))
        bezier2Path.addCurveToPoint(CGPointMake(6.6, 4.76), controlPoint1: CGPointMake(6, 4.52), controlPoint2: CGPointMake(6.24, 4.76))
        bezier2Path.addLineToPoint(CGPointMake(9.6, 4.76))
        bezier2Path.addLineToPoint(CGPointMake(9.6, 5.95))
        bezier2Path.addLineToPoint(CGPointMake(6.6, 5.95))
        bezier2Path.addCurveToPoint(CGPointMake(6, 6.55), controlPoint1: CGPointMake(6.24, 5.95), controlPoint2: CGPointMake(6, 6.19))
        bezier2Path.addLineToPoint(CGPointMake(6, 8.33))
        bezier2Path.addLineToPoint(CGPointMake(4.2, 8.33))
        bezier2Path.addCurveToPoint(CGPointMake(3.6, 8.93), controlPoint1: CGPointMake(3.84, 8.33), controlPoint2: CGPointMake(3.6, 8.57))
        bezier2Path.addLineToPoint(CGPointMake(3.6, 11.9))
        bezier2Path.addLineToPoint(CGPointMake(0.6, 11.9))
        bezier2Path.addCurveToPoint(CGPointMake(0, 12.5), controlPoint1: CGPointMake(0.24, 11.9), controlPoint2: CGPointMake(0, 12.14))
        bezier2Path.addLineToPoint(CGPointMake(0, 20.83))
        bezier2Path.addCurveToPoint(CGPointMake(0.6, 21.43), controlPoint1: CGPointMake(0, 21.19), controlPoint2: CGPointMake(0.24, 21.43))
        bezier2Path.addLineToPoint(CGPointMake(4.2, 21.43))
        bezier2Path.addCurveToPoint(CGPointMake(4.8, 20.83), controlPoint1: CGPointMake(4.56, 21.43), controlPoint2: CGPointMake(4.8, 21.19))
        bezier2Path.addLineToPoint(CGPointMake(4.8, 16.67))
        bezier2Path.addLineToPoint(CGPointMake(7.2, 16.67))
        bezier2Path.addLineToPoint(CGPointMake(7.2, 20.83))
        bezier2Path.addCurveToPoint(CGPointMake(7.8, 21.43), controlPoint1: CGPointMake(7.2, 21.19), controlPoint2: CGPointMake(7.44, 21.43))
        bezier2Path.addLineToPoint(CGPointMake(9.6, 21.43))
        bezier2Path.addLineToPoint(CGPointMake(9.6, 24.4))
        bezier2Path.addCurveToPoint(CGPointMake(10.2, 25), controlPoint1: CGPointMake(9.6, 24.76), controlPoint2: CGPointMake(9.84, 25))
        bezier2Path.addLineToPoint(CGPointMake(16.2, 25))
        bezier2Path.addCurveToPoint(CGPointMake(16.8, 24.4), controlPoint1: CGPointMake(16.56, 25), controlPoint2: CGPointMake(16.8, 24.76))
        bezier2Path.addLineToPoint(CGPointMake(16.8, 20.83))
        bezier2Path.addCurveToPoint(CGPointMake(16.2, 20.24), controlPoint1: CGPointMake(16.8, 20.48), controlPoint2: CGPointMake(16.56, 20.24))
        bezier2Path.addLineToPoint(CGPointMake(10.8, 20.24))
        bezier2Path.addLineToPoint(CGPointMake(10.8, 19.05))
        bezier2Path.addLineToPoint(CGPointMake(25.2, 19.05))
        bezier2Path.addLineToPoint(CGPointMake(25.2, 20.24))
        bezier2Path.addLineToPoint(CGPointMake(19.8, 20.24))
        bezier2Path.addCurveToPoint(CGPointMake(19.2, 20.83), controlPoint1: CGPointMake(19.44, 20.24), controlPoint2: CGPointMake(19.2, 20.48))
        bezier2Path.addLineToPoint(CGPointMake(19.2, 24.4))
        bezier2Path.addCurveToPoint(CGPointMake(19.8, 25), controlPoint1: CGPointMake(19.2, 24.76), controlPoint2: CGPointMake(19.44, 25))
        bezier2Path.addLineToPoint(CGPointMake(25.8, 25))
        bezier2Path.addCurveToPoint(CGPointMake(26.4, 24.4), controlPoint1: CGPointMake(26.16, 25), controlPoint2: CGPointMake(26.4, 24.76))
        bezier2Path.addLineToPoint(CGPointMake(26.4, 21.43))
        bezier2Path.addLineToPoint(CGPointMake(28.2, 21.43))
        bezier2Path.addCurveToPoint(CGPointMake(28.8, 20.83), controlPoint1: CGPointMake(28.56, 21.43), controlPoint2: CGPointMake(28.8, 21.19))
        bezier2Path.addLineToPoint(CGPointMake(28.8, 16.67))
        bezier2Path.addLineToPoint(CGPointMake(31.2, 16.67))
        bezier2Path.addLineToPoint(CGPointMake(31.2, 20.83))
        bezier2Path.addCurveToPoint(CGPointMake(31.8, 21.43), controlPoint1: CGPointMake(31.2, 21.19), controlPoint2: CGPointMake(31.44, 21.43))
        bezier2Path.addLineToPoint(CGPointMake(35.4, 21.43))
        bezier2Path.addCurveToPoint(CGPointMake(36, 20.83), controlPoint1: CGPointMake(35.76, 21.43), controlPoint2: CGPointMake(36, 21.19))
        bezier2Path.addLineToPoint(CGPointMake(36, 12.5))
        bezier2Path.addCurveToPoint(CGPointMake(35.4, 11.9), controlPoint1: CGPointMake(36, 12.14), controlPoint2: CGPointMake(35.7, 11.9))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(13.2, 11.9))
        bezier2Path.addLineToPoint(CGPointMake(10.8, 11.9))
        bezier2Path.addLineToPoint(CGPointMake(10.8, 9.52))
        bezier2Path.addLineToPoint(CGPointMake(13.2, 9.52))
        bezier2Path.addLineToPoint(CGPointMake(13.2, 11.9))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(25.2, 11.9))
        bezier2Path.addLineToPoint(CGPointMake(22.8, 11.9))
        bezier2Path.addLineToPoint(CGPointMake(22.8, 9.52))
        bezier2Path.addLineToPoint(CGPointMake(25.2, 9.52))
        bezier2Path.addLineToPoint(CGPointMake(25.2, 11.9))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}
