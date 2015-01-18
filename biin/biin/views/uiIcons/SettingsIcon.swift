//  SettingsIcon.swift
//  Biin
//  Created by Esteban Padilla on 12/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class SettingsIcon:BNIcon {
    
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
        
        //// Oval 2 Drawing
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(6, 15, 7.6, 7.6))
        color!.setStroke()
        oval2Path.lineWidth = stroke
        oval2Path.stroke()
        
        
        //// Oval 4 Drawing
        var oval4Path = UIBezierPath(ovalInRect: CGRectMake(21.2, 3.7, 3.8, 3.8))
        color!.setStroke()
        oval4Path.lineWidth = stroke
        oval4Path.stroke()
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(18, 18.8))
        bezier2Path.addCurveToPoint(CGPointMake(17.8, 17.1), controlPoint1: CGPointMake(18, 18.2), controlPoint2: CGPointMake(17.9, 17.6))
        bezier2Path.addLineToPoint(CGPointMake(19.8, 16))
        bezier2Path.addLineToPoint(CGPointMake(17.3, 11.6))
        bezier2Path.addLineToPoint(CGPointMake(15.4, 12.7))
        bezier2Path.addCurveToPoint(CGPointMake(12.5, 11), controlPoint1: CGPointMake(14.6, 11.9), controlPoint2: CGPointMake(13.7, 11.3))
        bezier2Path.addLineToPoint(CGPointMake(12.5, 8.9))
        bezier2Path.addLineToPoint(CGPointMake(7.5, 8.9))
        bezier2Path.addLineToPoint(CGPointMake(7.5, 11))
        bezier2Path.addCurveToPoint(CGPointMake(4.5, 12.7), controlPoint1: CGPointMake(6.2, 11.4), controlPoint2: CGPointMake(5.3, 12))
        bezier2Path.addLineToPoint(CGPointMake(2.5, 11.6))
        bezier2Path.addLineToPoint(CGPointMake(0, 16))
        bezier2Path.addLineToPoint(CGPointMake(2, 17.1))
        bezier2Path.addCurveToPoint(CGPointMake(1.8, 18.8), controlPoint1: CGPointMake(1.9, 17.7), controlPoint2: CGPointMake(1.8, 18.2))
        bezier2Path.addCurveToPoint(CGPointMake(2, 20.5), controlPoint1: CGPointMake(1.8, 19.4), controlPoint2: CGPointMake(1.9, 20))
        bezier2Path.addLineToPoint(CGPointMake(0, 21.6))
        bezier2Path.addLineToPoint(CGPointMake(2.5, 26))
        bezier2Path.addLineToPoint(CGPointMake(4.5, 24.8))
        bezier2Path.addCurveToPoint(CGPointMake(7.5, 26.5), controlPoint1: CGPointMake(5.3, 25.6), controlPoint2: CGPointMake(6.2, 26.2))
        bezier2Path.addLineToPoint(CGPointMake(7.5, 28.8))
        bezier2Path.addLineToPoint(CGPointMake(12.5, 28.8))
        bezier2Path.addLineToPoint(CGPointMake(12.5, 26.5))
        bezier2Path.addCurveToPoint(CGPointMake(15.4, 24.8), controlPoint1: CGPointMake(13.8, 26.1), controlPoint2: CGPointMake(14.6, 25.5))
        bezier2Path.addLineToPoint(CGPointMake(17.4, 26))
        bezier2Path.addLineToPoint(CGPointMake(19.9, 21.6))
        bezier2Path.addLineToPoint(CGPointMake(17.9, 20.5))
        bezier2Path.addCurveToPoint(CGPointMake(18, 18.8), controlPoint1: CGPointMake(18, 20), controlPoint2: CGPointMake(18, 19.4))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(27.5, 5.6))
        bezier4Path.addCurveToPoint(CGPointMake(27.4, 4.6), controlPoint1: CGPointMake(27.5, 5.2), controlPoint2: CGPointMake(27.5, 4.9))
        bezier4Path.addLineToPoint(CGPointMake(28.7, 3.9))
        bezier4Path.addLineToPoint(CGPointMake(27.4, 1.7))
        bezier4Path.addLineToPoint(CGPointMake(26.2, 2.4))
        bezier4Path.addCurveToPoint(CGPointMake(24.5, 1.4), controlPoint1: CGPointMake(25.7, 1.9), controlPoint2: CGPointMake(25.1, 1.6))
        bezier4Path.addLineToPoint(CGPointMake(24.5, 0))
        bezier4Path.addLineToPoint(CGPointMake(22, 0))
        bezier4Path.addLineToPoint(CGPointMake(22, 1.4))
        bezier4Path.addCurveToPoint(CGPointMake(20.2, 2.4), controlPoint1: CGPointMake(21.4, 1.6), controlPoint2: CGPointMake(20.7, 2))
        bezier4Path.addLineToPoint(CGPointMake(18.9, 1.7))
        bezier4Path.addLineToPoint(CGPointMake(17.6, 3.9))
        bezier4Path.addLineToPoint(CGPointMake(18.8, 4.6))
        bezier4Path.addCurveToPoint(CGPointMake(18.7, 5.6), controlPoint1: CGPointMake(18.7, 4.9), controlPoint2: CGPointMake(18.7, 5.3))
        bezier4Path.addCurveToPoint(CGPointMake(18.8, 6.6), controlPoint1: CGPointMake(18.7, 6), controlPoint2: CGPointMake(18.7, 6.3))
        bezier4Path.addLineToPoint(CGPointMake(17.5, 7.3))
        bezier4Path.addLineToPoint(CGPointMake(18.8, 9.5))
        bezier4Path.addLineToPoint(CGPointMake(20.1, 8.8))
        bezier4Path.addCurveToPoint(CGPointMake(21.9, 9.8), controlPoint1: CGPointMake(20.6, 9.3), controlPoint2: CGPointMake(21.3, 9.6))
        bezier4Path.addLineToPoint(CGPointMake(21.9, 11.2))
        bezier4Path.addLineToPoint(CGPointMake(24.4, 11.2))
        bezier4Path.addLineToPoint(CGPointMake(24.4, 9.8))
        bezier4Path.addCurveToPoint(CGPointMake(26.1, 8.8), controlPoint1: CGPointMake(25, 9.6), controlPoint2: CGPointMake(25.6, 9.2))
        bezier4Path.addLineToPoint(CGPointMake(27.3, 9.5))
        bezier4Path.addLineToPoint(CGPointMake(28.5, 7.3))
        bezier4Path.addLineToPoint(CGPointMake(27.2, 6.6))
        bezier4Path.addCurveToPoint(CGPointMake(27.5, 5.6), controlPoint1: CGPointMake(27.5, 6.3), controlPoint2: CGPointMake(27.5, 5.9))
        bezier4Path.closePath()
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = stroke
        bezier4Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
