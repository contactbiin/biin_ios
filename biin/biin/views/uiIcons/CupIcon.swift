//  CupIcon.swift
//  Biin
//  Created by Esteban Padilla on 9/12/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class CupIcon:BNIcon {
    
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
        
        //// Bezier 3 Drawing
        var bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(3.77, 8.18))
        bezier3Path.addCurveToPoint(CGPointMake(0.01, 1.31), controlPoint1: CGPointMake(-0.35, 8.18), controlPoint2: CGPointMake(0.01, 2.79))
        bezier3Path.addLineToPoint(CGPointMake(2.1, 1.31))
        bezier3Path.lineCapStyle = kCGLineCapRound;
        
        bezier3Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier3Path.lineWidth = stroke
        bezier3Path.stroke()
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(15.21, 8.18))
        bezier2Path.addCurveToPoint(CGPointMake(18.99, 1.31), controlPoint1: CGPointMake(19.33, 8.18), controlPoint2: CGPointMake(18.99, 2.45))
        bezier2Path.addLineToPoint(CGPointMake(16.91, 1.31))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(16.94, 0))
        bezierPath.addLineToPoint(CGPointMake(2.08, 0))
        bezierPath.addCurveToPoint(CGPointMake(8.65, 13.62), controlPoint1: CGPointMake(2.08, 12.74), controlPoint2: CGPointMake(8.65, 9.12))
        bezierPath.addCurveToPoint(CGPointMake(5.24, 17.34), controlPoint1: CGPointMake(8.6, 16.51), controlPoint2: CGPointMake(7.52, 17.34))
        bezierPath.addLineToPoint(CGPointMake(5.24, 18.98))
        bezierPath.addLineToPoint(CGPointMake(13.76, 18.98))
        bezierPath.addLineToPoint(CGPointMake(13.76, 17.34))
        bezierPath.addCurveToPoint(CGPointMake(10.3, 13.62), controlPoint1: CGPointMake(11.8, 17.34), controlPoint2: CGPointMake(10.3, 16.51))
        bezierPath.addCurveToPoint(CGPointMake(16.94, 0), controlPoint1: CGPointMake(10.3, 9.12), controlPoint2: CGPointMake(16.94, 12.69))
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

