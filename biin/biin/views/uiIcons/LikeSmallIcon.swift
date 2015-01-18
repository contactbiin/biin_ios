//  LikeSmallIcon.swift
//  Biin
//  Created by Esteban Padilla on 9/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.


import Foundation
import QuartzCore
import UIKit

class LikeSmallIcon:BNIcon {
    
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
        bezierPath.moveToPoint(CGPointMake(8.39, 0))
        bezierPath.addCurveToPoint(CGPointMake(5.75, 1.45), controlPoint1: CGPointMake(7.27, 0), controlPoint2: CGPointMake(6.3, 0.58))
        bezierPath.addCurveToPoint(CGPointMake(3.11, 0), controlPoint1: CGPointMake(5.2, 0.58), controlPoint2: CGPointMake(4.23, 0))
        bezierPath.addCurveToPoint(CGPointMake(0, 3.1), controlPoint1: CGPointMake(1.39, 0), controlPoint2: CGPointMake(0, 1.39))
        bezierPath.addCurveToPoint(CGPointMake(2.16, 7.4), controlPoint1: CGPointMake(0, 4.82), controlPoint2: CGPointMake(0.96, 6.2))
        bezierPath.addCurveToPoint(CGPointMake(5.75, 10.5), controlPoint1: CGPointMake(3.35, 8.59), controlPoint2: CGPointMake(5.27, 10.02))
        bezierPath.addCurveToPoint(CGPointMake(9.34, 7.4), controlPoint1: CGPointMake(6.23, 10.02), controlPoint2: CGPointMake(8.15, 8.59))
        bezierPath.addCurveToPoint(CGPointMake(11.5, 3.1), controlPoint1: CGPointMake(10.54, 6.2), controlPoint2: CGPointMake(11.5, 4.82))
        bezierPath.addCurveToPoint(CGPointMake(8.39, 0), controlPoint1: CGPointMake(11.5, 1.39), controlPoint2: CGPointMake(10.11, 0))
        bezierPath.addLineToPoint(CGPointMake(8.39, 0))
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
