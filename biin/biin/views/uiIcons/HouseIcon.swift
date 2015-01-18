//  HouseIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/12/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class HouseIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.scale = scale
        super.position = position
        super.stroke = stroke
        super.isFilled = isFilled
    }
    
    override func drawCanvas() {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Group
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(5.42, 17.87))
        bezier2Path.addLineToPoint(CGPointMake(5.42, 36.88))
        bezier2Path.addLineToPoint(CGPointMake(33.95, 36.88))
        bezier2Path.addLineToPoint(CGPointMake(33.95, 17.87))
        bezier2Path.addLineToPoint(CGPointMake(19.72, 3.52))
        bezier2Path.addLineToPoint(CGPointMake(5.42, 17.87))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        color!.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(39.19, 19.31))
        bezier4Path.addLineToPoint(CGPointMake(20.21, 0.2))
        bezier4Path.addCurveToPoint(CGPointMake(19.22, 0.2), controlPoint1: CGPointMake(19.99, -0.07), controlPoint2: CGPointMake(19.5, -0.07))
        bezier4Path.addLineToPoint(CGPointMake(0.18, 19.31))
        bezier4Path.addCurveToPoint(CGPointMake(0.07, 20.01), controlPoint1: CGPointMake(-0.04, 19.53), controlPoint2: CGPointMake(-0.04, 19.8))
        bezier4Path.addCurveToPoint(CGPointMake(0.24, 20.22), controlPoint1: CGPointMake(0.13, 20.06), controlPoint2: CGPointMake(0.18, 20.17))
        bezier4Path.addLineToPoint(CGPointMake(0.24, 20.22))
        bezier4Path.addCurveToPoint(CGPointMake(1.18, 20.22), controlPoint1: CGPointMake(0.51, 20.44), controlPoint2: CGPointMake(0.9, 20.44))
        bezier4Path.addLineToPoint(CGPointMake(1.18, 20.22))
        bezier4Path.addLineToPoint(CGPointMake(5.42, 15.94))
        bezier4Path.addLineToPoint(CGPointMake(5.42, 15.94))
        bezier4Path.addLineToPoint(CGPointMake(19.66, 1.59))
        bezier4Path.addLineToPoint(CGPointMake(38.2, 20.22))
        bezier4Path.addCurveToPoint(CGPointMake(39.14, 20.28), controlPoint1: CGPointMake(38.42, 20.49), controlPoint2: CGPointMake(38.86, 20.49))
        bezier4Path.addLineToPoint(CGPointMake(39.14, 20.28))
        bezier4Path.addCurveToPoint(CGPointMake(39.19, 19.31), controlPoint1: CGPointMake(39.47, 20.01), controlPoint2: CGPointMake(39.47, 19.58))
        bezier4Path.closePath()
        bezier4Path.miterLimit = 4;
        
        color!.setFill()
        bezier4Path.fill()
        
        
        
        CGContextRestoreGState(context)
    }
}