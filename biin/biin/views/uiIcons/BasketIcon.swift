//  BasketIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class BasketIcon:BNIcon {
    
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
        CGContextScaleCTM(context, scale, scale)
        
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(17.39, 20))
        bezierPath.addLineToPoint(CGPointMake(2.61, 20))
        bezierPath.addLineToPoint(CGPointMake(0.87, 10.34))
        bezierPath.addLineToPoint(CGPointMake(19.13, 10.34))
        bezierPath.addLineToPoint(CGPointMake(17.39, 20))
        bezierPath.closePath()
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        
        //// Bezier2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(6.9, 0.69))
        bezier2Path.addCurveToPoint(CGPointMake(1.66, 5.11), controlPoint1: CGPointMake(4.36, 0.69), controlPoint2: CGPointMake(2.22, 2.63))
        bezier2Path.addLineToPoint(CGPointMake(0.87, 8.97))
        bezier2Path.addLineToPoint(CGPointMake(19.13, 8.97))
        bezier2Path.addLineToPoint(CGPointMake(18.34, 5.11))
        bezier2Path.addCurveToPoint(CGPointMake(13.1, 0.69), controlPoint1: CGPointMake(17.78, 2.63), controlPoint2: CGPointMake(15.64, 0.69))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 9.03, 20, 1))
        color!.setStroke()
        rectanglePath.lineWidth = stroke
        rectanglePath.stroke()
        
        
        //// Bezier3 Drawing
        var bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(12.41, 12.17))
        bezier3Path.addLineToPoint(CGPointMake(12.41, 17.39))
        bezier3Path.lineCapStyle = kCGLineCapRound;
        
        bezier3Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier3Path.lineWidth = stroke
        bezier3Path.stroke()
        
        
        //// Bezier4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(15.17, 12.17))
        bezier4Path.addLineToPoint(CGPointMake(15.17, 17.39))
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier4Path.lineWidth = stroke
        bezier4Path.stroke()
        
        
        //// Bezier5 Drawing
        var bezier5Path = UIBezierPath()
        bezier5Path.moveToPoint(CGPointMake(7.59, 12.17))
        bezier5Path.addLineToPoint(CGPointMake(7.59, 17.39))
        bezier5Path.lineCapStyle = kCGLineCapRound;
        
        bezier5Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier5Path.lineWidth = stroke
        bezier5Path.stroke()
        
        
        //// Bezier6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(4.83, 12.17))
        bezier6Path.addLineToPoint(CGPointMake(4.83, 17.39))
        bezier6Path.lineCapStyle = kCGLineCapRound;
        
        bezier6Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier6Path.lineWidth = stroke
        bezier6Path.stroke()
        
        
        //// Bezier7 Drawing
        var bezier7Path = UIBezierPath()
        bezier7Path.moveToPoint(CGPointMake(13.1, 0.69))
        bezier7Path.addCurveToPoint(CGPointMake(12.07, 1.38), controlPoint1: CGPointMake(13.1, 1.17), controlPoint2: CGPointMake(12.65, 1.38))
        bezier7Path.addLineToPoint(CGPointMake(7.93, 1.38))
        bezier7Path.addCurveToPoint(CGPointMake(6.9, 0.69), controlPoint1: CGPointMake(7.35, 1.38), controlPoint2: CGPointMake(6.9, 1.17))
        bezier7Path.addCurveToPoint(CGPointMake(7.93, 0), controlPoint1: CGPointMake(6.9, 0.21), controlPoint2: CGPointMake(7.45, 0))
        bezier7Path.addLineToPoint(CGPointMake(12.07, 0))
        bezier7Path.addCurveToPoint(CGPointMake(13.1, 0.69), controlPoint1: CGPointMake(12.55, 0), controlPoint2: CGPointMake(13.1, 0.21))
        bezier7Path.closePath()
        bezier7Path.lineCapStyle = kCGLineCapRound;
        
        bezier7Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier7Path.lineWidth = stroke
        bezier7Path.stroke()
        
        
        
        CGContextRestoreGState(context)

    }
    
}