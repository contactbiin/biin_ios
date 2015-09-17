//  BNIcon_TVMedium.swift
//  biin
//  Created by Esteban Padilla on 1/22/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_TVMedium:BNIcon {
    
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
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(2, 14.5))
        bezier2Path.addCurveToPoint(CGPointMake(2, 18), controlPoint1: CGPointMake(2, 14.5), controlPoint2: CGPointMake(2, 17))
        bezier2Path.addCurveToPoint(CGPointMake(7.5, 20), controlPoint1: CGPointMake(2, 19), controlPoint2: CGPointMake(3, 20))
        bezier2Path.addCurveToPoint(CGPointMake(10.5, 20), controlPoint1: CGPointMake(10.5, 20), controlPoint2: CGPointMake(7.5, 20))
        bezier2Path.addCurveToPoint(CGPointMake(16, 18), controlPoint1: CGPointMake(15, 20), controlPoint2: CGPointMake(16, 19))
        bezier2Path.addCurveToPoint(CGPointMake(16, 14.5), controlPoint1: CGPointMake(16, 17), controlPoint2: CGPointMake(16, 14.5))
        bezier2Path.addCurveToPoint(CGPointMake(16, 10), controlPoint1: CGPointMake(16, 14.5), controlPoint2: CGPointMake(16, 11))
        bezier2Path.addCurveToPoint(CGPointMake(10.5, 8), controlPoint1: CGPointMake(16, 9), controlPoint2: CGPointMake(15, 8))
        bezier2Path.addCurveToPoint(CGPointMake(7.5, 8), controlPoint1: CGPointMake(7.5, 8), controlPoint2: CGPointMake(10.5, 8))
        bezier2Path.addCurveToPoint(CGPointMake(2, 10), controlPoint1: CGPointMake(3, 8), controlPoint2: CGPointMake(2, 9))
        bezier2Path.addCurveToPoint(CGPointMake(2, 14.5), controlPoint1: CGPointMake(2, 11), controlPoint2: CGPointMake(2, 14.5))
        bezier2Path.closePath()
        color!.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(7.5, 5.5))
        bezier4Path.addCurveToPoint(CGPointMake(11.6, 3), controlPoint1: CGPointMake(8.3, 4), controlPoint2: CGPointMake(9.8, 3))
        bezier4Path.addCurveToPoint(CGPointMake(15.6, 5.5), controlPoint1: CGPointMake(13.4, 3), controlPoint2: CGPointMake(14.9, 4))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(13.6, 3.4))
        bezier6Path.addLineToPoint(CGPointMake(17, 0))
        bezier6Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.stroke()
        
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(9.5, 3.4))
        bezier8Path.addLineToPoint(CGPointMake(6, 0))
        bezier8Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.stroke()
        
        
        //// Group 2
        //// Bezier 10 Drawing
        let bezier10Path = UIBezierPath()
        bezier10Path.moveToPoint(CGPointMake(19.6, 9.5))
        bezier10Path.addCurveToPoint(CGPointMake(20.6, 10.5), controlPoint1: CGPointMake(20.2, 9.5), controlPoint2: CGPointMake(20.6, 9.9))
        bezier10Path.addCurveToPoint(CGPointMake(19.6, 11.5), controlPoint1: CGPointMake(20.6, 11.1), controlPoint2: CGPointMake(20.2, 11.5))
        bezier10Path.addCurveToPoint(CGPointMake(18.6, 10.5), controlPoint1: CGPointMake(19, 11.5), controlPoint2: CGPointMake(18.6, 11.1))
        bezier10Path.addCurveToPoint(CGPointMake(19.6, 9.5), controlPoint1: CGPointMake(18.6, 9.9), controlPoint2: CGPointMake(19, 9.5))
        bezier10Path.closePath()
        bezier10Path.moveToPoint(CGPointMake(19.6, 8.5))
        bezier10Path.addCurveToPoint(CGPointMake(17.6, 10.5), controlPoint1: CGPointMake(18.5, 8.5), controlPoint2: CGPointMake(17.6, 9.4))
        bezier10Path.addCurveToPoint(CGPointMake(19.6, 12.5), controlPoint1: CGPointMake(17.6, 11.6), controlPoint2: CGPointMake(18.5, 12.5))
        bezier10Path.addCurveToPoint(CGPointMake(21.6, 10.5), controlPoint1: CGPointMake(20.7, 12.5), controlPoint2: CGPointMake(21.6, 11.6))
        bezier10Path.addCurveToPoint(CGPointMake(19.6, 8.5), controlPoint1: CGPointMake(21.6, 9.4), controlPoint2: CGPointMake(20.7, 8.5))
        bezier10Path.addLineToPoint(CGPointMake(19.6, 8.5))
        bezier10Path.closePath()
        bezier10Path.miterLimit = 4;
        
        color!.setFill()
        bezier10Path.fill()
        
        
        
        
        //// Group 3
        //// Bezier 12 Drawing
        let bezier12Path = UIBezierPath()
        bezier12Path.moveToPoint(CGPointMake(19.6, 14.5))
        bezier12Path.addCurveToPoint(CGPointMake(20.6, 15.5), controlPoint1: CGPointMake(20.2, 14.5), controlPoint2: CGPointMake(20.6, 14.9))
        bezier12Path.addCurveToPoint(CGPointMake(19.6, 16.5), controlPoint1: CGPointMake(20.6, 16.1), controlPoint2: CGPointMake(20.2, 16.5))
        bezier12Path.addCurveToPoint(CGPointMake(18.6, 15.5), controlPoint1: CGPointMake(19, 16.5), controlPoint2: CGPointMake(18.6, 16.1))
        bezier12Path.addCurveToPoint(CGPointMake(19.6, 14.5), controlPoint1: CGPointMake(18.6, 14.9), controlPoint2: CGPointMake(19, 14.5))
        bezier12Path.closePath()
        bezier12Path.moveToPoint(CGPointMake(19.6, 13.5))
        bezier12Path.addCurveToPoint(CGPointMake(17.6, 15.5), controlPoint1: CGPointMake(18.5, 13.5), controlPoint2: CGPointMake(17.6, 14.4))
        bezier12Path.addCurveToPoint(CGPointMake(19.6, 17.5), controlPoint1: CGPointMake(17.6, 16.6), controlPoint2: CGPointMake(18.5, 17.5))
        bezier12Path.addCurveToPoint(CGPointMake(21.6, 15.5), controlPoint1: CGPointMake(20.7, 17.5), controlPoint2: CGPointMake(21.6, 16.6))
        bezier12Path.addCurveToPoint(CGPointMake(19.6, 13.5), controlPoint1: CGPointMake(21.6, 14.4), controlPoint2: CGPointMake(20.7, 13.5))
        bezier12Path.addLineToPoint(CGPointMake(19.6, 13.5))
        bezier12Path.closePath()
        bezier12Path.miterLimit = 4;
        
        color!.setFill()
        bezier12Path.fill()
        
        
        
        
        //// Bezier 14 Drawing
        let bezier14Path = UIBezierPath()
        bezier14Path.moveToPoint(CGPointMake(23, 19))
        bezier14Path.addCurveToPoint(CGPointMake(20, 22), controlPoint1: CGPointMake(23, 20.6), controlPoint2: CGPointMake(21.6, 22))
        bezier14Path.addLineToPoint(CGPointMake(3, 22))
        bezier14Path.addCurveToPoint(CGPointMake(0, 19), controlPoint1: CGPointMake(1.3, 22), controlPoint2: CGPointMake(0, 20.6))
        bezier14Path.addLineToPoint(CGPointMake(0, 9))
        bezier14Path.addCurveToPoint(CGPointMake(3, 6), controlPoint1: CGPointMake(0, 7.4), controlPoint2: CGPointMake(1.3, 6))
        bezier14Path.addLineToPoint(CGPointMake(20, 6))
        bezier14Path.addCurveToPoint(CGPointMake(23, 9), controlPoint1: CGPointMake(21.6, 6), controlPoint2: CGPointMake(23, 7.4))
        bezier14Path.addLineToPoint(CGPointMake(23, 19))
        bezier14Path.closePath()
        color!.setStroke()
        bezier14Path.lineWidth = 1
        bezier14Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}