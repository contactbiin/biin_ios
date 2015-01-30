//  BNIcon_SmileMedium.swift
//  biin
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_SmileMedium:BNIcon {
    
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
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 23, 23))
        color!.setStroke()
        oval2Path.lineWidth = 1
        oval2Path.stroke()
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(19, 12.5))
        bezier2Path.addCurveToPoint(CGPointMake(11.5, 20), controlPoint1: CGPointMake(19, 16.6), controlPoint2: CGPointMake(15.6, 20))
        bezier2Path.addCurveToPoint(CGPointMake(4, 12.5), controlPoint1: CGPointMake(7.4, 20), controlPoint2: CGPointMake(4, 16.6))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(18, 7.5))
        bezier4Path.addCurveToPoint(CGPointMake(16, 9.5), controlPoint1: CGPointMake(18, 8.6), controlPoint2: CGPointMake(17.1, 9.5))
        bezier4Path.addCurveToPoint(CGPointMake(14, 7.5), controlPoint1: CGPointMake(14.9, 9.5), controlPoint2: CGPointMake(14, 8.6))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(5, 7.5))
        bezier6Path.addCurveToPoint(CGPointMake(7, 9.5), controlPoint1: CGPointMake(5, 8.6), controlPoint2: CGPointMake(5.9, 9.5))
        bezier6Path.addCurveToPoint(CGPointMake(9, 7.5), controlPoint1: CGPointMake(8.1, 9.5), controlPoint2: CGPointMake(9, 8.6))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
