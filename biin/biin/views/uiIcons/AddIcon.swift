//  AddIcon.swift
//  Biin
//  Created by Esteban Padilla on 7/21/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class AddIcon:BNIcon {
    
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
        bezierPath.moveToPoint(CGPointMake(35, 22.5))
        bezierPath.addLineToPoint(CGPointMake(22.55, 22.5))
        bezierPath.addLineToPoint(CGPointMake(10, 22.5))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(22.5, 10))
        bezier2Path.addLineToPoint(CGPointMake(22.5, 22.41))
        bezier2Path.addLineToPoint(CGPointMake(22.5, 35))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        var bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(22.5, 45))
        bezier3Path.addCurveToPoint(CGPointMake(0, 22.5), controlPoint1: CGPointMake(10.07, 45), controlPoint2: CGPointMake(0, 34.93))
        bezier3Path.addCurveToPoint(CGPointMake(22.5, 0), controlPoint1: CGPointMake(0, 10.07), controlPoint2: CGPointMake(10.07, 0))
        bezier3Path.addCurveToPoint(CGPointMake(45, 22.5), controlPoint1: CGPointMake(34.93, 0), controlPoint2: CGPointMake(45, 10.07))
        bezier3Path.addCurveToPoint(CGPointMake(22.89, 45), controlPoint1: CGPointMake(45, 34.8), controlPoint2: CGPointMake(35.14, 44.79))
        bezier3Path.lineCapStyle = kCGLineCapRound;
        
        color!.setStroke()
        bezier3Path.lineWidth = stroke
        bezier3Path.stroke()
        
        CGContextRestoreGState(context)
    }
}