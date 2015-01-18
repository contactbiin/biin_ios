//  CompletedCircleIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/5/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class CompletedCircleIcon:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(100, 50))
        bezier2Path.addCurveToPoint(CGPointMake(50, 100), controlPoint1: CGPointMake(100, 77.6), controlPoint2: CGPointMake(77.6, 100))
        bezier2Path.addCurveToPoint(CGPointMake(0, 50), controlPoint1: CGPointMake(22.4, 100), controlPoint2: CGPointMake(0, 77.6))
        bezier2Path.addCurveToPoint(CGPointMake(50, 0), controlPoint1: CGPointMake(0, 22.4), controlPoint2: CGPointMake(22.4, 0))
        bezier2Path.addCurveToPoint(CGPointMake(100, 50), controlPoint1: CGPointMake(77.6, 0), controlPoint2: CGPointMake(100, 22.4))
        bezier2Path.closePath()
        color!.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(69, 30))
        bezier4Path.addLineToPoint(CGPointMake(40.8, 58.2))
        bezier4Path.addLineToPoint(CGPointMake(32.9, 50.3))
        bezier4Path.addLineToPoint(CGPointMake(25, 58.2))
        bezier4Path.addLineToPoint(CGPointMake(40.8, 74))
        bezier4Path.addLineToPoint(CGPointMake(76.9, 37.9))
        bezier4Path.addLineToPoint(CGPointMake(69, 30))
        bezier4Path.closePath()
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}