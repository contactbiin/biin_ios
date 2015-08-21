//  BNIcon_BiinItButton.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_BiinItButton:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color1 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// biinButton.svg Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(24, 35))
        bezierPath.addLineToPoint(CGPointMake(11, 35))
        bezierPath.addCurveToPoint(CGPointMake(0, 24), controlPoint1: CGPointMake(4.9, 35), controlPoint2: CGPointMake(0, 30.1))
        bezierPath.addLineToPoint(CGPointMake(0, 11))
        bezierPath.addCurveToPoint(CGPointMake(11, 0), controlPoint1: CGPointMake(0, 4.9), controlPoint2: CGPointMake(4.9, 0))
        bezierPath.addLineToPoint(CGPointMake(24, 0))
        bezierPath.addCurveToPoint(CGPointMake(35, 11), controlPoint1: CGPointMake(30.1, 0), controlPoint2: CGPointMake(35, 4.9))
        bezierPath.addLineToPoint(CGPointMake(35, 24))
        bezierPath.addCurveToPoint(CGPointMake(24, 35), controlPoint1: CGPointMake(35, 30.1), controlPoint2: CGPointMake(30, 35))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        color!.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, (position.x + 8.25), (position.y + 10))
        
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(12.13, 0))
        bezier2Path.addCurveToPoint(CGPointMake(8.53, 1.7), controlPoint1: CGPointMake(10.69, 0), controlPoint2: CGPointMake(9.37, 0.67))
        bezier2Path.addCurveToPoint(CGPointMake(4.87, 0), controlPoint1: CGPointMake(7.63, 0.67), controlPoint2: CGPointMake(6.37, 0))
        bezier2Path.addCurveToPoint(CGPointMake(0, 4.98), controlPoint1: CGPointMake(2.16, 0), controlPoint2: CGPointMake(0, 2.25))
        bezier2Path.addCurveToPoint(CGPointMake(8.53, 15), controlPoint1: CGPointMake(0, 11.23), controlPoint2: CGPointMake(8.53, 15))
        bezier2Path.addCurveToPoint(CGPointMake(17, 4.98), controlPoint1: CGPointMake(8.53, 15), controlPoint2: CGPointMake(17, 11.23))
        bezier2Path.addCurveToPoint(CGPointMake(12.13, 0), controlPoint1: CGPointMake(17, 2.19), controlPoint2: CGPointMake(14.84, 0))
        bezier2Path.closePath()
        color1.setStroke()
        bezier2Path.lineWidth = 2.84
        bezier2Path.stroke()
        
        CGContextRestoreGState(context)
        
        

    }
}