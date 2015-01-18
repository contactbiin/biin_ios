//  QuestionIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/29/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class QuestionIcon:BNIcon {
    
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
        
        //// Oval Drawing
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(3.75, 13.35, 1, 1))
        color!.setStroke()
        ovalPath.lineWidth = stroke
        ovalPath.stroke()
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 4.52))
        bezierPath.addCurveToPoint(CGPointMake(4.4, 0), controlPoint1: CGPointMake(0, 2.08), controlPoint2: CGPointMake(1.97, 0))
        bezierPath.addCurveToPoint(CGPointMake(8.81, 4.39), controlPoint1: CGPointMake(6.84, 0), controlPoint2: CGPointMake(8.81, 1.94))
        bezierPath.addCurveToPoint(CGPointMake(4.25, 8.49), controlPoint1: CGPointMake(8.81, 6.83), controlPoint2: CGPointMake(6.68, 8.49))
        bezierPath.addLineToPoint(CGPointMake(4.25, 10.84))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    }
}
