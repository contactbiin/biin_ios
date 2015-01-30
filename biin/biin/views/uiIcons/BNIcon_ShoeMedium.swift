//  BNIcon_ShoeMedium.swift
//  biin
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_ShoeMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(9, 9))
        bezier2Path.addLineToPoint(CGPointMake(22.3, 13.8))
        bezier2Path.addCurveToPoint(CGPointMake(23, 14.7), controlPoint1: CGPointMake(22.7, 13.9), controlPoint2: CGPointMake(23, 14.3))
        bezier2Path.addLineToPoint(CGPointMake(23, 17))
        bezier2Path.addLineToPoint(CGPointMake(0, 17))
        bezier2Path.addLineToPoint(CGPointMake(0, 10))
        bezier2Path.addCurveToPoint(CGPointMake(1, 9), controlPoint1: CGPointMake(0, 9.4), controlPoint2: CGPointMake(0.4, 9))
        bezier2Path.addLineToPoint(CGPointMake(2, 9))
        bezier2Path.addCurveToPoint(CGPointMake(5.5, 10.5), controlPoint1: CGPointMake(2, 9.8), controlPoint2: CGPointMake(3.8, 10.5))
        bezier2Path.addCurveToPoint(CGPointMake(9, 9), controlPoint1: CGPointMake(7.7, 10.5), controlPoint2: CGPointMake(9, 9.8))
        bezier2Path.closePath()
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(0, 15))
        bezier4Path.addLineToPoint(CGPointMake(23, 15))
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(11.6, 9.9))
        bezier6Path.addLineToPoint(CGPointMake(10.5, 11))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(13.4, 10.6))
        bezier8Path.addLineToPoint(CGPointMake(12.5, 11.5))
        bezier8Path.lineCapStyle = kCGLineCapRound;
        
        bezier8Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(17, 11.9))
        bezier10Path.addCurveToPoint(CGPointMake(16, 13), controlPoint1: CGPointMake(17, 12.5), controlPoint2: CGPointMake(16.6, 13))
        bezier10Path.addLineToPoint(CGPointMake(13, 13))
        bezier10Path.addCurveToPoint(CGPointMake(11.5, 14.5), controlPoint1: CGPointMake(12.2, 13), controlPoint2: CGPointMake(11.5, 13.7))
        bezier10Path.addLineToPoint(CGPointMake(11.5, 15))
        bezier10Path.lineJoinStyle = kCGLineJoinRound;
    
        color!.setStroke()
        bezier10Path.lineWidth = 1
        bezier10Path.stroke()
        
        
        //// Bezier 12 Drawing
        var bezier12Path = UIBezierPath()
        bezier12Path.moveToPoint(CGPointMake(3, 15))
        bezier12Path.addCurveToPoint(CGPointMake(0, 12), controlPoint1: CGPointMake(3, 13.3), controlPoint2: CGPointMake(1.7, 12))
        bezier12Path.lineCapStyle = kCGLineCapRound;
        
        bezier12Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier12Path.lineWidth = 1
        bezier12Path.stroke()
        
        
        //// Bezier 14 Drawing
        var bezier14Path = UIBezierPath()
        bezier14Path.moveToPoint(CGPointMake(14, 8))
        bezier14Path.addLineToPoint(CGPointMake(0.7, 3.2))
        bezier14Path.addCurveToPoint(CGPointMake(0, 2.3), controlPoint1: CGPointMake(0.3, 3.1), controlPoint2: CGPointMake(0, 2.7))
        bezier14Path.addLineToPoint(CGPointMake(0, 0))
        bezier14Path.addLineToPoint(CGPointMake(23, 0))
        bezier14Path.addLineToPoint(CGPointMake(23, 7))
        bezier14Path.addCurveToPoint(CGPointMake(22, 8), controlPoint1: CGPointMake(23, 7.6), controlPoint2: CGPointMake(22.6, 8))
        bezier14Path.addLineToPoint(CGPointMake(21, 8))
        bezier14Path.addCurveToPoint(CGPointMake(17.5, 6.5), controlPoint1: CGPointMake(21, 7.2), controlPoint2: CGPointMake(19.2, 6.5))
        bezier14Path.addCurveToPoint(CGPointMake(14, 8), controlPoint1: CGPointMake(15.3, 6.5), controlPoint2: CGPointMake(14, 7.2))
        bezier14Path.closePath()
        bezier14Path.lineCapStyle = kCGLineCapRound;
        
        bezier14Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier14Path.lineWidth = 1
        bezier14Path.stroke()
        
        
        //// Bezier 16 Drawing
        var bezier16Path = UIBezierPath()
        bezier16Path.moveToPoint(CGPointMake(23, 2))
        bezier16Path.addLineToPoint(CGPointMake(0, 2))
        bezier16Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier16Path.lineWidth = 1
        bezier16Path.stroke()
        
        
        //// Bezier 18 Drawing
        var bezier18Path = UIBezierPath()
        bezier18Path.moveToPoint(CGPointMake(11.4, 7.1))
        bezier18Path.addLineToPoint(CGPointMake(12.5, 6))
        bezier18Path.lineCapStyle = kCGLineCapRound;
        
        bezier18Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier18Path.lineWidth = 1
        bezier18Path.stroke()
        
        
        //// Bezier 20 Drawing
        var bezier20Path = UIBezierPath()
        bezier20Path.moveToPoint(CGPointMake(9.6, 6.4))
        bezier20Path.addLineToPoint(CGPointMake(10.5, 5.5))
        bezier20Path.lineCapStyle = kCGLineCapRound;
        
        bezier20Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier20Path.lineWidth = 1
        bezier20Path.stroke()
        
        
        //// Bezier 22 Drawing
        var bezier22Path = UIBezierPath()
        bezier22Path.moveToPoint(CGPointMake(6, 5.1))
        bezier22Path.addCurveToPoint(CGPointMake(7, 4), controlPoint1: CGPointMake(6, 4.5), controlPoint2: CGPointMake(6.4, 4))
        bezier22Path.addLineToPoint(CGPointMake(10, 4))
        bezier22Path.addCurveToPoint(CGPointMake(11.5, 2.5), controlPoint1: CGPointMake(10.8, 4), controlPoint2: CGPointMake(11.5, 3.3))
        bezier22Path.addLineToPoint(CGPointMake(11.5, 2))
        bezier22Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier22Path.lineWidth = 1
        bezier22Path.stroke()
        
        
        //// Bezier 24 Drawing
        var bezier24Path = UIBezierPath()
        bezier24Path.moveToPoint(CGPointMake(20, 2))
        bezier24Path.addCurveToPoint(CGPointMake(23, 5), controlPoint1: CGPointMake(20, 3.7), controlPoint2: CGPointMake(21.3, 5))
        bezier24Path.lineCapStyle = kCGLineCapRound;
        
        bezier24Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier24Path.lineWidth = 1
        bezier24Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
