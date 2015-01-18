//  BiinBIcon.swift
//  Biin
//  Created by Esteban Padilla on 9/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class BiinBIcon:BNIcon {
    
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
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(2.02, 3.04))
        bezierPath.addCurveToPoint(CGPointMake(3.75, 2.65), controlPoint1: CGPointMake(2.53, 2.79), controlPoint2: CGPointMake(3.12, 2.65))
        bezierPath.addCurveToPoint(CGPointMake(7.5, 6.08), controlPoint1: CGPointMake(5.82, 2.65), controlPoint2: CGPointMake(7.5, 4.19))
        bezierPath.addCurveToPoint(CGPointMake(3.75, 9.5), controlPoint1: CGPointMake(7.5, 7.97), controlPoint2: CGPointMake(5.82, 9.5))
        bezierPath.addCurveToPoint(CGPointMake(0, 6.08), controlPoint1: CGPointMake(1.68, 9.5), controlPoint2: CGPointMake(0, 7.97))
        bezierPath.addLineToPoint(CGPointMake(0, 0))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
        
    }
}