//  BNIcon_MiniBiin.swift
//  biin
//  Created by Esteban Padilla on 4/15/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_MiniBiin:BNIcon {
    
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
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(3.77, 5.95))
        bezier2Path.addCurveToPoint(CGPointMake(6.99, 5.19), controlPoint1: CGPointMake(4.75, 5.48), controlPoint2: CGPointMake(5.83, 5.19))
        bezier2Path.addCurveToPoint(CGPointMake(13.94, 11.9), controlPoint1: CGPointMake(10.84, 5.19), controlPoint2: CGPointMake(13.94, 8.18))
        bezier2Path.addCurveToPoint(CGPointMake(6.99, 18.6), controlPoint1: CGPointMake(13.94, 15.61), controlPoint2: CGPointMake(10.84, 18.6))
        bezier2Path.addCurveToPoint(CGPointMake(0, 11.9), controlPoint1: CGPointMake(3.14, 18.6), controlPoint2: CGPointMake(0, 15.61))
        bezier2Path.addLineToPoint(CGPointMake(0, 0))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 2.5
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(18.09, 18.6))
        bezier4Path.addLineToPoint(CGPointMake(18.09, 9.19))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = 2.5
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(22.28, 18.6))
        bezier6Path.addLineToPoint(CGPointMake(22.28, 9.19))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = 2.5
        bezier6Path.stroke()
        
        
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(21, 3.4, 3.2, 3.2))
        color!.setFill()
        oval2Path.fill()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(37.6, 18.6))
        bezier8Path.addLineToPoint(CGPointMake(37.6, 10.56))
        bezier8Path.addCurveToPoint(CGPointMake(32.03, 5.19), controlPoint1: CGPointMake(37.6, 7.61), controlPoint2: CGPointMake(35.1, 5.19))
        bezier8Path.addCurveToPoint(CGPointMake(26.46, 10.56), controlPoint1: CGPointMake(28.97, 5.19), controlPoint2: CGPointMake(26.46, 7.61))
        bezier8Path.addLineToPoint(CGPointMake(26.46, 18.6))
        bezier8Path.lineCapStyle = kCGLineCapRound;
        
        bezier8Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier8Path.lineWidth = 2.5
        bezier8Path.stroke()
        
        
        //// Oval 4 Drawing
        var oval4Path = UIBezierPath(ovalInRect: CGRectMake(16.9, 3.4, 2.2, 3.2))
        color!.setFill()
        oval4Path.fill()
        
        
        
        CGContextRestoreGState(context)
        
    }
}