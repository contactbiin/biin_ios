//  MapIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/19/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class MapIcon:BNIcon {
    
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
        bezierPath.moveToPoint(CGPointMake(15, 7.21))
        bezierPath.addCurveToPoint(CGPointMake(7.5, 19), controlPoint1: CGPointMake(15, 13.76), controlPoint2: CGPointMake(7.5, 19))
        bezierPath.addCurveToPoint(CGPointMake(0, 7.21), controlPoint1: CGPointMake(7.5, 19), controlPoint2: CGPointMake(0, 13.76))
        bezierPath.addCurveToPoint(CGPointMake(7.5, 0), controlPoint1: CGPointMake(0, 3.23), controlPoint2: CGPointMake(3.54, 0))
        bezierPath.addCurveToPoint(CGPointMake(15, 7.21), controlPoint1: CGPointMake(11.46, 0), controlPoint2: CGPointMake(15, 3.23))
        bezierPath.closePath()
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        //// Oval Drawing
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(2.45, 2.48, 10.09, 10.17))
        color!.setStroke()
        ovalPath.lineWidth = stroke
        ovalPath.stroke()
        
        CGContextRestoreGState(context)
    }
}
