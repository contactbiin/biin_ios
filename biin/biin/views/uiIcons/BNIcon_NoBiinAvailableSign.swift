//  BNIcon_NoBiinAvailableSign.swift
//  biin
//  Created by Esteban Padilla on 5/20/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_NoBiinAvailableSign:BNIcon {
    
    init(color:UIColor, position:CGPoint){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group 2
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(86.1, 82.9))
        bezierPath.addLineToPoint(CGPointMake(86.1, 150.6))
        bezierPath.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezierPath.lineWidth = 5
        bezierPath.stroke()
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(61.5, 33.7, 49.2, 49.2))
        color!.setStroke()
        ovalPath.lineWidth = 5
        ovalPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(149.5, 0))
        bezier2Path.addCurveToPoint(CGPointMake(172.2, 58.3), controlPoint1: CGPointMake(163.6, 15.3), controlPoint2: CGPointMake(172.2, 35.8))
        bezier2Path.addCurveToPoint(CGPointMake(139.4, 126), controlPoint1: CGPointMake(172.2, 85.7), controlPoint2: CGPointMake(159.4, 110.2))
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 5
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(32.8, 126))
        bezier3Path.addCurveToPoint(CGPointMake(0, 58.3), controlPoint1: CGPointMake(12.8, 110.2), controlPoint2: CGPointMake(0, 85.8))
        bezier3Path.addCurveToPoint(CGPointMake(22.7, 0), controlPoint1: CGPointMake(0, 35.8), controlPoint2: CGPointMake(8.6, 15.4))
        bezier3Path.lineCapStyle = CGLineCap.Round;
        
        color!.setStroke()
        bezier3Path.lineWidth = 5
        bezier3Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(51.7, 101.7))
        bezier4Path.addCurveToPoint(CGPointMake(30.8, 58.3), controlPoint1: CGPointMake(39, 91.6), controlPoint2: CGPointMake(30.8, 75.9))
        bezier4Path.addCurveToPoint(CGPointMake(44.9, 21.4), controlPoint1: CGPointMake(30.8, 44.1), controlPoint2: CGPointMake(36.1, 31.2))
        bezier4Path.lineCapStyle = CGLineCap.Round;
        
        bezier4Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier4Path.lineWidth = 5
        bezier4Path.stroke()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.moveToPoint(CGPointMake(127.3, 21.3))
        bezier5Path.addCurveToPoint(CGPointMake(141.5, 58.3), controlPoint1: CGPointMake(136.1, 31.1), controlPoint2: CGPointMake(141.5, 44.1))
        bezier5Path.addCurveToPoint(CGPointMake(120.8, 101.5), controlPoint1: CGPointMake(141.5, 75.8), controlPoint2: CGPointMake(133.4, 91.4))
        bezier5Path.lineCapStyle = CGLineCap.Round;
        
        bezier5Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier5Path.lineWidth = 5
        bezier5Path.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}