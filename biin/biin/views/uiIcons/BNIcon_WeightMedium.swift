//  BNIcon_WeightMedium.swift
//  biin
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_WeightMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(9.5, 13.6))
        bezier2Path.addLineToPoint(CGPointMake(8, 13.6))
        bezier2Path.addCurveToPoint(CGPointMake(6, 11.6), controlPoint1: CGPointMake(6.9, 13.6), controlPoint2: CGPointMake(6, 12.7))
        bezier2Path.addLineToPoint(CGPointMake(6, 2))
        bezier2Path.addCurveToPoint(CGPointMake(8, 0), controlPoint1: CGPointMake(6, 0.9), controlPoint2: CGPointMake(6.9, 0))
        bezier2Path.addLineToPoint(CGPointMake(9.5, 0))
        bezier2Path.addCurveToPoint(CGPointMake(11.5, 2), controlPoint1: CGPointMake(10.6, 0), controlPoint2: CGPointMake(11.5, 0.9))
        bezier2Path.addLineToPoint(CGPointMake(11.5, 11.6))
        bezier2Path.addCurveToPoint(CGPointMake(9.5, 13.6), controlPoint1: CGPointMake(11.5, 12.7), controlPoint2: CGPointMake(10.6, 13.6))
        bezier2Path.closePath()
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(4.6, 11.2))
        bezier4Path.addLineToPoint(CGPointMake(3, 11.2))
        bezier4Path.addCurveToPoint(CGPointMake(1, 9.2), controlPoint1: CGPointMake(1.9, 11.2), controlPoint2: CGPointMake(1, 10.3))
        bezier4Path.addLineToPoint(CGPointMake(1, 4.4))
        bezier4Path.addCurveToPoint(CGPointMake(3, 2.4), controlPoint1: CGPointMake(1, 3.3), controlPoint2: CGPointMake(1.9, 2.4))
        bezier4Path.addLineToPoint(CGPointMake(4.5, 2.4))
        bezier4Path.addLineToPoint(CGPointMake(4.5, 11.2))
        bezier4Path.addLineToPoint(CGPointMake(4.6, 11.2))
        bezier4Path.closePath()
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(12, 6.9))
        bezier6Path.addLineToPoint(CGPointMake(14, 6.9))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(16, 13.6))
        bezier8Path.addLineToPoint(CGPointMake(17.5, 13.6))
        bezier8Path.addCurveToPoint(CGPointMake(19.5, 11.6), controlPoint1: CGPointMake(18.6, 13.6), controlPoint2: CGPointMake(19.5, 12.7))
        bezier8Path.addLineToPoint(CGPointMake(19.5, 2))
        bezier8Path.addCurveToPoint(CGPointMake(17.5, 0), controlPoint1: CGPointMake(19.5, 0.9), controlPoint2: CGPointMake(18.6, 0))
        bezier8Path.addLineToPoint(CGPointMake(16, 0))
        bezier8Path.addCurveToPoint(CGPointMake(14, 2), controlPoint1: CGPointMake(14.9, 0), controlPoint2: CGPointMake(14, 0.9))
        bezier8Path.addLineToPoint(CGPointMake(14, 11.6))
        bezier8Path.addCurveToPoint(CGPointMake(16, 13.6), controlPoint1: CGPointMake(14, 12.7), controlPoint2: CGPointMake(14.9, 13.6))
        bezier8Path.closePath()
        color!.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(21, 11.2))
        bezier10Path.addLineToPoint(CGPointMake(22.5, 11.2))
        bezier10Path.addCurveToPoint(CGPointMake(24.5, 9.2), controlPoint1: CGPointMake(23.6, 11.2), controlPoint2: CGPointMake(24.5, 10.3))
        bezier10Path.addLineToPoint(CGPointMake(24.5, 4.4))
        bezier10Path.addCurveToPoint(CGPointMake(22.5, 2.4), controlPoint1: CGPointMake(24.5, 3.3), controlPoint2: CGPointMake(23.6, 2.4))
        bezier10Path.addLineToPoint(CGPointMake(21, 2.4))
        bezier10Path.addLineToPoint(CGPointMake(21, 11.2))
        bezier10Path.closePath()
        color!.setStroke()
        bezier10Path.lineWidth = 1
        bezier10Path.stroke()
        
        
        //// Bezier 12 Drawing
        var bezier12Path = UIBezierPath()
        bezier12Path.moveToPoint(CGPointMake(25, 6.9))
        bezier12Path.addLineToPoint(CGPointMake(26, 6.9))
        bezier12Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier12Path.lineWidth = 1
        bezier12Path.stroke()
        
        
        //// Bezier 14 Drawing
        var bezier14Path = UIBezierPath()
        bezier14Path.moveToPoint(CGPointMake(0, 6.9))
        bezier14Path.addLineToPoint(CGPointMake(1, 6.9))
        bezier14Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier14Path.lineWidth = 1
        bezier14Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
