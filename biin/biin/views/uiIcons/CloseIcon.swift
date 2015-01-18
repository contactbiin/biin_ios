//  CloseIcon.swift
//  Biin
//  Created by Esteban Padilla on 8/16/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import UIKit
import QuartzCore

class CloseIcon:BNIcon {
    
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
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(-0, 10))
        bezier2Path.addLineToPoint(CGPointMake(10, -0))
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        bezier2Path.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
        
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(10, 10))
        bezierPath.addLineToPoint(CGPointMake(-0, -0))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        
        
        CGContextRestoreGState(context)
    
    }
}