//  CrossitIcon.swift
//  Biin
//  Created by Esteban Padilla on 9/17/14.
//  Copyright (c) 2014 Biin. All rights reserved.

import Foundation
import QuartzCore
import UIKit

class CrossitIcon:BNIcon {
    
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
        CGContextTranslateCTM(context, (position.x + 1), (position.y + 1))
        CGContextScaleCTM(context, scale, scale)
        
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 7))
        bezierPath.addLineToPoint(CGPointMake(34, 0))
        bezierPath.moveToPoint(CGPointMake(0, 0))
        bezierPath.addLineToPoint(CGPointMake(34, 7))
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        
        color!.setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        CGContextRestoreGState(context)
    }
}