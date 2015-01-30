//  BNIcon_UmbrellaMedium.swift
//  biin
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_UmbrellaMedium:BNIcon {
    
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
        bezier2Path.moveToPoint(CGPointMake(23, 16.02))
        bezier2Path.addLineToPoint(CGPointMake(17, 16.02))
        bezier2Path.addCurveToPoint(CGPointMake(11, 18.02), controlPoint1: CGPointMake(14.5, 16.02), controlPoint2: CGPointMake(12.4, 16.82))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(17, 16.02))
        bezier4Path.addLineToPoint(CGPointMake(13.7, 7.62))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(11.1, 1.12))
        bezier6Path.addLineToPoint(CGPointMake(10.8, 0.22))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(11.1, 1.12))
        bezier8Path.addCurveToPoint(CGPointMake(4.5, 10.22), controlPoint1: CGPointMake(6.2, 3.02), controlPoint2: CGPointMake(3.1, 6.62))
        bezier8Path.addLineToPoint(CGPointMake(4.9, 11.12))
        bezier8Path.addLineToPoint(CGPointMake(7.2, 10.22))
        bezier8Path.addLineToPoint(CGPointMake(7.8, 8.92))
        bezier8Path.addLineToPoint(CGPointMake(9.1, 9.52))
        bezier8Path.addLineToPoint(CGPointMake(18.4, 5.82))
        bezier8Path.addLineToPoint(CGPointMake(19, 4.52))
        bezier8Path.addLineToPoint(CGPointMake(20.2, 5.02))
        bezier8Path.addLineToPoint(CGPointMake(22.5, 4.12))
        bezier8Path.addLineToPoint(CGPointMake(22.2, 3.22))
        bezier8Path.addCurveToPoint(CGPointMake(11.1, 1.12), controlPoint1: CGPointMake(20.8, -0.38), controlPoint2: CGPointMake(16, -0.78))
        bezier8Path.closePath()
        bezier8Path.lineCapStyle = kCGLineCapRound;
        
        bezier8Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        //// Bezier 10 Drawing
        var bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(23, 22.02))
        bezier10Path.addCurveToPoint(CGPointMake(21, 20.02), controlPoint1: CGPointMake(22, 22.02), controlPoint2: CGPointMake(21, 21.12))
        bezier10Path.addCurveToPoint(CGPointMake(19, 22.02), controlPoint1: CGPointMake(21, 21.12), controlPoint2: CGPointMake(20, 22.02))
        bezier10Path.addCurveToPoint(CGPointMake(17, 20.02), controlPoint1: CGPointMake(18, 22.02), controlPoint2: CGPointMake(17, 21.12))
        bezier10Path.addCurveToPoint(CGPointMake(15, 22.02), controlPoint1: CGPointMake(17, 21.12), controlPoint2: CGPointMake(16, 22.02))
        bezier10Path.addCurveToPoint(CGPointMake(13, 20.02), controlPoint1: CGPointMake(14, 22.02), controlPoint2: CGPointMake(13, 21.12))
        bezier10Path.addCurveToPoint(CGPointMake(11, 22.02), controlPoint1: CGPointMake(13, 21.12), controlPoint2: CGPointMake(12, 22.02))
        bezier10Path.addCurveToPoint(CGPointMake(9, 20.02), controlPoint1: CGPointMake(10, 22.02), controlPoint2: CGPointMake(9, 21.12))
        bezier10Path.addCurveToPoint(CGPointMake(7, 22.02), controlPoint1: CGPointMake(9, 21.12), controlPoint2: CGPointMake(8, 22.02))
        bezier10Path.addCurveToPoint(CGPointMake(5, 20.02), controlPoint1: CGPointMake(6, 22.02), controlPoint2: CGPointMake(5, 21.12))
        bezier10Path.addCurveToPoint(CGPointMake(3, 22.02), controlPoint1: CGPointMake(5, 21.12), controlPoint2: CGPointMake(4, 22.02))
        bezier10Path.addCurveToPoint(CGPointMake(1, 20.02), controlPoint1: CGPointMake(2, 22.02), controlPoint2: CGPointMake(1, 21.12))
        bezier10Path.addCurveToPoint(CGPointMake(0, 21.72), controlPoint1: CGPointMake(1, 20.72), controlPoint2: CGPointMake(0.5, 21.32))
        bezier10Path.lineCapStyle = kCGLineCapRound;
        
        bezier10Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier10Path.lineWidth = 1
        bezier10Path.stroke()
        
        CGContextRestoreGState(context)
    }
}