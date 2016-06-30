//  BNIcon_SettingsMedium.swift
//  biin
//  Created by Esteban Padilla on 2/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_SettingsMedium:BNIcon {
    
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

        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(8, 8.1, 10.6, 10.6))
        color!.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(24.33, 13.38))
        bezier2Path.addCurveToPoint(CGPointMake(24.06, 11.08), controlPoint1: CGPointMake(24.33, 12.57), controlPoint2: CGPointMake(24.2, 11.76))
        bezier2Path.addLineToPoint(CGPointMake(26.76, 9.6))
        bezier2Path.addLineToPoint(CGPointMake(23.39, 3.65))
        bezier2Path.addLineToPoint(CGPointMake(20.82, 5.14))
        bezier2Path.addCurveToPoint(CGPointMake(16.9, 2.84), controlPoint1: CGPointMake(19.74, 4.06), controlPoint2: CGPointMake(18.52, 3.24))
        bezier2Path.addLineToPoint(CGPointMake(16.9, 0))
        bezier2Path.addLineToPoint(CGPointMake(10.14, 0))
        bezier2Path.addLineToPoint(CGPointMake(10.14, 2.84))
        bezier2Path.addCurveToPoint(CGPointMake(6.08, 5.14), controlPoint1: CGPointMake(8.38, 3.38), controlPoint2: CGPointMake(7.16, 4.19))
        bezier2Path.addLineToPoint(CGPointMake(3.38, 3.65))
        bezier2Path.addLineToPoint(CGPointMake(0, 9.6))
        bezier2Path.addLineToPoint(CGPointMake(2.7, 11.08))
        bezier2Path.addCurveToPoint(CGPointMake(2.43, 13.38), controlPoint1: CGPointMake(2.57, 11.9), controlPoint2: CGPointMake(2.43, 12.57))
        bezier2Path.addCurveToPoint(CGPointMake(2.7, 15.68), controlPoint1: CGPointMake(2.43, 14.19), controlPoint2: CGPointMake(2.57, 15))
        bezier2Path.addLineToPoint(CGPointMake(0, 17.17))
        bezier2Path.addLineToPoint(CGPointMake(3.38, 23.12))
        bezier2Path.addLineToPoint(CGPointMake(6.08, 21.49))
        bezier2Path.addCurveToPoint(CGPointMake(10.14, 23.79), controlPoint1: CGPointMake(7.16, 22.57), controlPoint2: CGPointMake(8.38, 23.39))
        bezier2Path.addLineToPoint(CGPointMake(10.14, 26.9))
        bezier2Path.addLineToPoint(CGPointMake(16.9, 26.9))
        bezier2Path.addLineToPoint(CGPointMake(16.9, 23.79))
        bezier2Path.addCurveToPoint(CGPointMake(20.82, 21.49), controlPoint1: CGPointMake(18.65, 23.25), controlPoint2: CGPointMake(19.74, 22.44))
        bezier2Path.addLineToPoint(CGPointMake(23.52, 23.12))
        bezier2Path.addLineToPoint(CGPointMake(26.9, 17.17))
        bezier2Path.addLineToPoint(CGPointMake(24.2, 15.68))
        bezier2Path.addCurveToPoint(CGPointMake(24.33, 13.38), controlPoint1: CGPointMake(24.2, 15), controlPoint2: CGPointMake(24.33, 14.19))
        bezier2Path.closePath()
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
