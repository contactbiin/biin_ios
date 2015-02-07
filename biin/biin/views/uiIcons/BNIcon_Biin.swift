//  BNIcon_Biin.swift
//  biin
//  Created by Esteban Padilla on 2/6/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_Biin:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(10.1, 16.5))
        bezier2Path.addCurveToPoint(CGPointMake(18.7, 14.4), controlPoint1: CGPointMake(12.7, 15.2), controlPoint2: CGPointMake(15.6, 14.4))
        bezier2Path.addCurveToPoint(CGPointMake(37.3, 33), controlPoint1: CGPointMake(29, 14.4), controlPoint2: CGPointMake(37.3, 22.7))
        bezier2Path.addCurveToPoint(CGPointMake(18.7, 51.6), controlPoint1: CGPointMake(37.3, 43.3), controlPoint2: CGPointMake(29, 51.6))
        bezier2Path.addCurveToPoint(CGPointMake(0, 33), controlPoint1: CGPointMake(8.4, 51.6), controlPoint2: CGPointMake(0, 43.3))
        bezier2Path.addLineToPoint(CGPointMake(0, 0))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 7
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(48.4, 51.6))
        bezier4Path.addLineToPoint(CGPointMake(48.4, 25.5))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = 7
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(59.6, 51.6))
        bezier6Path.addLineToPoint(CGPointMake(59.6, 25.5))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = 7
        bezier6Path.stroke()
        
        
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(56, 10.4, 7.2, 7.2))
        color!.setFill()
        oval2Path.fill()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(100.6, 51.6))
        bezier8Path.addLineToPoint(CGPointMake(100.6, 29.3))
        bezier8Path.addCurveToPoint(CGPointMake(85.7, 14.4), controlPoint1: CGPointMake(100.6, 21.1), controlPoint2: CGPointMake(93.9, 14.4))
        bezier8Path.addCurveToPoint(CGPointMake(70.8, 29.3), controlPoint1: CGPointMake(77.5, 14.4), controlPoint2: CGPointMake(70.8, 21.1))
        bezier8Path.addLineToPoint(CGPointMake(70.8, 51.6))
        bezier8Path.lineCapStyle = kCGLineCapRound;
        
        bezier8Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier8Path.lineWidth = 7
        bezier8Path.stroke()
    
        //// Oval 4 Drawing
        var oval4Path = UIBezierPath(ovalInRect: CGRectMake(44.9, 10.4, 7.2, 7.2))
        color!.setFill()
        oval4Path.fill()

        CGContextRestoreGState(context)

    }
}
