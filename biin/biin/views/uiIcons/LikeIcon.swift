//  LikeIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/2/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class LikeIcon:BNIcon {
    
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
        bezierPath.moveToPoint(CGPointMake(12.76, 0))
        bezierPath.addCurveToPoint(CGPointMake(8.75, 2.15), controlPoint1: CGPointMake(11.07, 0), controlPoint2: CGPointMake(9.59, 0.86))
        bezierPath.addCurveToPoint(CGPointMake(4.74, 0), controlPoint1: CGPointMake(7.91, 0.86), controlPoint2: CGPointMake(6.43, 0))
        bezierPath.addCurveToPoint(CGPointMake(0, 4.58), controlPoint1: CGPointMake(2.12, 0), controlPoint2: CGPointMake(0, 2.05))
        bezierPath.addCurveToPoint(CGPointMake(3.28, 10.92), controlPoint1: CGPointMake(0, 7.11), controlPoint2: CGPointMake(1.46, 9.16))
        bezierPath.addCurveToPoint(CGPointMake(8.75, 15.5), controlPoint1: CGPointMake(5.1, 12.68), controlPoint2: CGPointMake(8.02, 14.8))
        bezierPath.addCurveToPoint(CGPointMake(14.22, 10.92), controlPoint1: CGPointMake(9.48, 14.8), controlPoint2: CGPointMake(12.39, 12.68))
        bezierPath.addCurveToPoint(CGPointMake(17.5, 4.58), controlPoint1: CGPointMake(16.04, 9.16), controlPoint2: CGPointMake(17.5, 7.11))
        bezierPath.addCurveToPoint(CGPointMake(12.76, 0), controlPoint1: CGPointMake(17.5, 2.05), controlPoint2: CGPointMake(15.37, 0))
        bezierPath.addLineToPoint(CGPointMake(12.76, 0))
        bezierPath.closePath()
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        if isFilled {
            color!.setFill()
            bezierPath.fill()
        }
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}