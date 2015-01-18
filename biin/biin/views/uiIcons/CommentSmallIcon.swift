//
//  CommentSmallIcon.swift
//  Biin
//
//  Created by Esteban Padilla on 9/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.
//


import Foundation
import QuartzCore
import UIKit

class CommentSmallIcon:BNIcon {
    
    init(color:UIColor, scale:CGFloat, position:CGPoint, stroke:CGFloat, isFilled:Bool){
        super.init()
        super.color = color
        super.scale = scale
        super.position = position
        super.stroke = stroke
        super.isFilled = isFilled
    }
    
    override func drawCanvas() {
        let context = UIGraphicsGetCurrentContext()
        
        //// Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, position.x, position.y)
        CGContextScaleCTM(context, scale, scale)
        
        
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(11.5, 4.68))
        bezierPath.addCurveToPoint(CGPointMake(5.75, 9.28), controlPoint1: CGPointMake(11.5, 7.22), controlPoint2: CGPointMake(8.93, 9.28))
        bezierPath.addCurveToPoint(CGPointMake(3.77, 8.95), controlPoint1: CGPointMake(5.04, 9.28), controlPoint2: CGPointMake(4.39, 9.13))
        bezierPath.addLineToPoint(CGPointMake(0.43, 10.5))
        bezierPath.addLineToPoint(CGPointMake(1.78, 7.97))
        bezierPath.addCurveToPoint(CGPointMake(0, 4.68), controlPoint1: CGPointMake(0.72, 7.14), controlPoint2: CGPointMake(0, 5.97))
        bezierPath.addCurveToPoint(CGPointMake(5.75, 0), controlPoint1: CGPointMake(0, 2.14), controlPoint2: CGPointMake(2.57, 0))
        bezierPath.addCurveToPoint(CGPointMake(11.5, 4.68), controlPoint1: CGPointMake(8.93, 0), controlPoint2: CGPointMake(11.5, 2.14))
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
