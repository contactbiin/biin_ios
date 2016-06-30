//  BNIcon_JoinGameIcon.swift
//  biin
//  Created by Esteban Padilla on 2/4/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BNIcon_JoinGameIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.position = position
    }
    
    override func drawCanvas() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Group 3
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(48.5, 81.6))
        bezier2Path.addLineToPoint(CGPointMake(33, 81.6))
        bezier2Path.addCurveToPoint(CGPointMake(0, 48.6), controlPoint1: CGPointMake(14.8, 81.6), controlPoint2: CGPointMake(0, 66.8))
        bezier2Path.addLineToPoint(CGPointMake(0, 33))
        bezier2Path.addCurveToPoint(CGPointMake(33, 0), controlPoint1: CGPointMake(0, 14.8), controlPoint2: CGPointMake(14.8, 0))
        bezier2Path.addLineToPoint(CGPointMake(48.6, 0))
        bezier2Path.addCurveToPoint(CGPointMake(81.6, 33), controlPoint1: CGPointMake(66.8, 0), controlPoint2: CGPointMake(81.6, 14.8))
        bezier2Path.addLineToPoint(CGPointMake(81.6, 48.6))
        bezier2Path.addCurveToPoint(CGPointMake(48.5, 81.6), controlPoint1: CGPointMake(81.5, 66.8), controlPoint2: CGPointMake(66.8, 81.6))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        bezier2Path.lineCapStyle = CGLineCap.Round;
        
        bezier2Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setStroke()
        bezier2Path.lineWidth = 3
        bezier2Path.stroke()
        
        //// Group 2
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(17.7, 27.3, 6.4, 6.4))
        color!.setFill()
        oval2Path.fill()
        color!.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()
        
        
        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalInRect: CGRectMake(57.5, 27.3, 6.4, 6.4))
        color!.setFill()
        oval4Path.fill()
        color!.setStroke()
        oval4Path.lineWidth = 2
        oval4Path.stroke()
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(24.9, 59.9))
        bezier6Path.addLineToPoint(CGPointMake(56.7, 59.9))
        bezier6Path.lineCapStyle = CGLineCap.Round;
        
        bezier6Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setFill()
        bezier6Path.fill()
        color!.setStroke()
        bezier6Path.lineWidth = 2
        bezier6Path.stroke()
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(24.9, 56.7))
        bezier8Path.addLineToPoint(CGPointMake(20.9, 33.6))
        bezier8Path.addCurveToPoint(CGPointMake(31.2, 43.9), controlPoint1: CGPointMake(20.9, 33.6), controlPoint2: CGPointMake(23.2, 43.9))
        bezier8Path.addCurveToPoint(CGPointMake(40.7, 29.6), controlPoint1: CGPointMake(39.2, 43.9), controlPoint2: CGPointMake(40.7, 29.6))
        bezier8Path.addCurveToPoint(CGPointMake(51, 43.9), controlPoint1: CGPointMake(40.7, 29.6), controlPoint2: CGPointMake(43, 43.9))
        bezier8Path.addCurveToPoint(CGPointMake(60.7, 33.6), controlPoint1: CGPointMake(59, 43.9), controlPoint2: CGPointMake(60.7, 33.6))
        bezier8Path.addLineToPoint(CGPointMake(56.7, 56.7))
        bezier8Path.addLineToPoint(CGPointMake(24.9, 56.7))
        bezier8Path.closePath()
        bezier8Path.lineCapStyle = CGLineCap.Round;
        
        bezier8Path.lineJoinStyle = CGLineJoin.Round;
        
        color!.setFill()
        bezier8Path.fill()
        color!.setStroke()
        bezier8Path.lineWidth = 2
        bezier8Path.stroke()
        
        //// Oval 6 Drawing
        let oval6Path = UIBezierPath(ovalInRect: CGRectMake(36.8, 21.7, 8, 8))
        color!.setFill()
        oval6Path.fill()
        color!.setStroke()
        oval6Path.lineWidth = 2
        oval6Path.stroke()
        
        CGContextRestoreGState(context)
    }
}
